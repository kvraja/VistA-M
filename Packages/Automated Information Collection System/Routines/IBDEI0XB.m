IBDEI0XB ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15357,1,3,0)
 ;;=3^Open Wound of Head,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,15357,1,4,0)
 ;;=4^S01.90XA
 ;;^UTILITY(U,$J,358.3,15357,2)
 ;;=^5020240
 ;;^UTILITY(U,$J,358.3,15358,0)
 ;;=S11.80XA^^85^817^31
 ;;^UTILITY(U,$J,358.3,15358,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15358,1,3,0)
 ;;=3^Open Wound of Neck NEC,Init Encntr
 ;;^UTILITY(U,$J,358.3,15358,1,4,0)
 ;;=4^S11.80XA
 ;;^UTILITY(U,$J,358.3,15358,2)
 ;;=^5021506
 ;;^UTILITY(U,$J,358.3,15359,0)
 ;;=S11.90XA^^85^817^32
 ;;^UTILITY(U,$J,358.3,15359,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15359,1,3,0)
 ;;=3^Open Wound of Neck,Unspec,Init Encntr
 ;;^UTILITY(U,$J,358.3,15359,1,4,0)
 ;;=4^S11.90XA
 ;;^UTILITY(U,$J,358.3,15359,2)
 ;;=^5021527
 ;;^UTILITY(U,$J,358.3,15360,0)
 ;;=S31.819A^^85^817^37
 ;;^UTILITY(U,$J,358.3,15360,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15360,1,3,0)
 ;;=3^Open Wound of Right Buttock,Init Encntr
 ;;^UTILITY(U,$J,358.3,15360,1,4,0)
 ;;=4^S31.819A
 ;;^UTILITY(U,$J,358.3,15360,2)
 ;;=^5024308
 ;;^UTILITY(U,$J,358.3,15361,0)
 ;;=S31.829A^^85^817^6
 ;;^UTILITY(U,$J,358.3,15361,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15361,1,3,0)
 ;;=3^Open Wound of Left Buttock,Init Encntr
 ;;^UTILITY(U,$J,358.3,15361,1,4,0)
 ;;=4^S31.829A
 ;;^UTILITY(U,$J,358.3,15361,2)
 ;;=^5024320
 ;;^UTILITY(U,$J,358.3,15362,0)
 ;;=S31.100A^^85^817^35
 ;;^UTILITY(U,$J,358.3,15362,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15362,1,3,0)
 ;;=3^Open Wound of RUQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,15362,1,4,0)
 ;;=4^S31.100A
 ;;^UTILITY(U,$J,358.3,15362,2)
 ;;=^5024023
 ;;^UTILITY(U,$J,358.3,15363,0)
 ;;=S31.101A^^85^817^4
 ;;^UTILITY(U,$J,358.3,15363,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15363,1,3,0)
 ;;=3^Open Wound of LUQ Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,15363,1,4,0)
 ;;=4^S31.101A
 ;;^UTILITY(U,$J,358.3,15363,2)
 ;;=^5024026
 ;;^UTILITY(U,$J,358.3,15364,0)
 ;;=S31.103A^^85^817^34
 ;;^UTILITY(U,$J,358.3,15364,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15364,1,3,0)
 ;;=3^Open Wound of RLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,15364,1,4,0)
 ;;=4^S31.103A
 ;;^UTILITY(U,$J,358.3,15364,2)
 ;;=^5024032
 ;;^UTILITY(U,$J,358.3,15365,0)
 ;;=S31.104A^^85^817^3
 ;;^UTILITY(U,$J,358.3,15365,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15365,1,3,0)
 ;;=3^Open Wound of LLQ of Abd Wall w/o Penet Perit Cav,Init Encntr
 ;;^UTILITY(U,$J,358.3,15365,1,4,0)
 ;;=4^S31.104A
 ;;^UTILITY(U,$J,358.3,15365,2)
 ;;=^5134415
 ;;^UTILITY(U,$J,358.3,15366,0)
 ;;=S41.001A^^85^817^57
 ;;^UTILITY(U,$J,358.3,15366,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15366,1,3,0)
 ;;=3^Open Wound of Right Shoulder,Init Encntr
 ;;^UTILITY(U,$J,358.3,15366,1,4,0)
 ;;=4^S41.001A
 ;;^UTILITY(U,$J,358.3,15366,2)
 ;;=^5026291
 ;;^UTILITY(U,$J,358.3,15367,0)
 ;;=S41.002A^^85^817^26
 ;;^UTILITY(U,$J,358.3,15367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15367,1,3,0)
 ;;=3^Open Wound of Left Shoulder,Init Encntr
 ;;^UTILITY(U,$J,358.3,15367,1,4,0)
 ;;=4^S41.002A
 ;;^UTILITY(U,$J,358.3,15367,2)
 ;;=^5026294
 ;;^UTILITY(U,$J,358.3,15368,0)
 ;;=S51.001A^^85^817^39
 ;;^UTILITY(U,$J,358.3,15368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15368,1,3,0)
 ;;=3^Open Wound of Right Elbow,Init Encntr
 ;;^UTILITY(U,$J,358.3,15368,1,4,0)
 ;;=4^S51.001A
 ;;^UTILITY(U,$J,358.3,15368,2)
 ;;=^5028620
 ;;^UTILITY(U,$J,358.3,15369,0)
 ;;=S51.002A^^85^817^8
 ;;^UTILITY(U,$J,358.3,15369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15369,1,3,0)
 ;;=3^Open Wound of Left Elbow,Init Encntr
