#Create a simulator object
set ns [new Simulator]

#Open the output files
set f [open abw.tr w]

# シミュレーション終了定義
proc finish {} {
	global f
	## the output filesクローズ
	close $f    
    exit 0
}

set bw 1000000000
set size 1500
#set interval 0.001
set rate 400000000

# node生成
## src
set n0 [$ns node]
set n1 [$ns node]
## mid
set n2 [$ns node]
set n3 [$ns node]
## sink
set n4 [$ns node]
set n5 [$ns node]

# リンク設定
## src side
$ns duplex-link $n0 $n2 3000Mb 10ms DropTail
$ns duplex-link $n1 $n2 3000Mb 10ms DropTail
## bottleneck link
$ns duplex-link $n2 $n3 $bw 10ms DropTail
# sink side
$ns duplex-link $n4 $n3 3000Mb 10ms DropTail
$ns duplex-link $n5 $n3 3000Mb 10ms DropTail


# CBRのトラヒックジェネレータを利用した接続
proc attach-cbr-traffic { node sink size rate } {
	set ns [Simulator instance]

	## UDPエージェントをノードにセット
	set source [new Agent/UDP]
	$ns attach-agent $node $source

	## CBRトラヒックジェネレータのパラメータ設定
	set traffic [new Application/Traffic/CBR]
	$traffic set packetSize_ $size
        #$traffic set interval_ $interval
        $traffic set rate_ $rate

    	## トラヒックジェネレータをsrcにセット
    	$traffic attach-agent $source
	## srcとsink間にフローを定義
	$ns connect $source $sink
	return $traffic
}


# 可用帯域計算及び記録
proc record {} {
    global sink0 bw f
	
	set ns [Simulator instance]
	
    ## 帯域計算間隔
    set time 0.5

	## 受信バイト数取得
    set bw0 [$sink0 set bytes_]
    ## 現在の時刻取得
    set now [$ns now]
    
    ## 使用帯域計算
    puts $f "$now [expr $bw/(1000000)-$bw0/$time*8/(1000*1000)]"
	
    ## 初期化
    $sink0 set bytes_ 0
	
    ## 再帰呼び出し
    $ns at [expr $now+$time] "record"
}


# sinkの定義
set sink0 [new Agent/LossMonitor]
$ns attach-agent $n3 $sink0


# クロストラヒックフローを定義
set source0 [attach-cbr-traffic $n0 $sink0 $size $rate]


# シミューレーション設定
$ns at 0.0 "record"
$ns at 0.5 "$source0 start"
$ns at 400.0 "$source0 stop"
$ns at 400.0 "finish"
$ns run
