IBDEI0IR ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9140,0)
 ;;=172.9^^61^639^24
 ;;^UTILITY(U,$J,358.3,9140,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9140,1,4,0)
 ;;=4^Malig Melanoma Skin
 ;;^UTILITY(U,$J,358.3,9140,1,5,0)
 ;;=5^172.9
 ;;^UTILITY(U,$J,358.3,9140,2)
 ;;=^75462
 ;;^UTILITY(U,$J,358.3,9141,0)
 ;;=728.6^^61^639^16
 ;;^UTILITY(U,$J,358.3,9141,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9141,1,4,0)
 ;;=4^Dupuytren's Contracture
 ;;^UTILITY(U,$J,358.3,9141,1,5,0)
 ;;=5^728.6
 ;;^UTILITY(U,$J,358.3,9141,2)
 ;;=^28077
 ;;^UTILITY(U,$J,358.3,9142,0)
 ;;=703.0^^61^639^21
 ;;^UTILITY(U,$J,358.3,9142,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9142,1,4,0)
 ;;=4^Ingrowing Nail
 ;;^UTILITY(U,$J,358.3,9142,1,5,0)
 ;;=5^703.0
 ;;^UTILITY(U,$J,358.3,9142,2)
 ;;=^81221
 ;;^UTILITY(U,$J,358.3,9143,0)
 ;;=214.1^^61^639^23
 ;;^UTILITY(U,$J,358.3,9143,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9143,1,4,0)
 ;;=4^Lipoma, other than face
 ;;^UTILITY(U,$J,358.3,9143,1,5,0)
 ;;=5^214.1
 ;;^UTILITY(U,$J,358.3,9143,2)
 ;;=Lipoma, other than face^267615
 ;;^UTILITY(U,$J,358.3,9144,0)
 ;;=707.10^^61^639^37
 ;;^UTILITY(U,$J,358.3,9144,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9144,1,4,0)
 ;;=4^Ulcer, LE, not specified
 ;;^UTILITY(U,$J,358.3,9144,1,5,0)
 ;;=5^707.10
 ;;^UTILITY(U,$J,358.3,9144,2)
 ;;=Ulcer, LE, not specified^322142
 ;;^UTILITY(U,$J,358.3,9145,0)
 ;;=707.11^^61^639^42
 ;;^UTILITY(U,$J,358.3,9145,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9145,1,4,0)
 ;;=4^Ulcer,Thigh
 ;;^UTILITY(U,$J,358.3,9145,1,5,0)
 ;;=5^707.11
 ;;^UTILITY(U,$J,358.3,9145,2)
 ;;=^322143
 ;;^UTILITY(U,$J,358.3,9146,0)
 ;;=707.12^^61^639^40
 ;;^UTILITY(U,$J,358.3,9146,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9146,1,4,0)
 ;;=4^Ulcer,Calf
 ;;^UTILITY(U,$J,358.3,9146,1,5,0)
 ;;=5^707.12
 ;;^UTILITY(U,$J,358.3,9146,2)
 ;;=^322144
 ;;^UTILITY(U,$J,358.3,9147,0)
 ;;=707.13^^61^639^39
 ;;^UTILITY(U,$J,358.3,9147,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9147,1,4,0)
 ;;=4^Ulcer,Ankle
 ;;^UTILITY(U,$J,358.3,9147,1,5,0)
 ;;=5^707.13
 ;;^UTILITY(U,$J,358.3,9147,2)
 ;;=^322145
 ;;^UTILITY(U,$J,358.3,9148,0)
 ;;=707.14^^61^639^41
 ;;^UTILITY(U,$J,358.3,9148,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9148,1,4,0)
 ;;=4^Ulcer,Heel Midfoot
 ;;^UTILITY(U,$J,358.3,9148,1,5,0)
 ;;=5^707.14
 ;;^UTILITY(U,$J,358.3,9148,2)
 ;;=^322146
 ;;^UTILITY(U,$J,358.3,9149,0)
 ;;=707.15^^61^639^35
 ;;^UTILITY(U,$J,358.3,9149,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9149,1,4,0)
 ;;=4^Ulcer of Toe
 ;;^UTILITY(U,$J,358.3,9149,1,5,0)
 ;;=5^707.15
 ;;^UTILITY(U,$J,358.3,9149,2)
 ;;=Ulcer of Toe^322148
 ;;^UTILITY(U,$J,358.3,9150,0)
 ;;=707.19^^61^639^38
 ;;^UTILITY(U,$J,358.3,9150,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9150,1,4,0)
 ;;=4^Ulcer, Other part of LE
 ;;^UTILITY(U,$J,358.3,9150,1,5,0)
 ;;=5^707.19
 ;;^UTILITY(U,$J,358.3,9150,2)
 ;;=Ulcer, Other part of LE^322150
 ;;^UTILITY(U,$J,358.3,9151,0)
 ;;=214.0^^61^639^22
 ;;^UTILITY(U,$J,358.3,9151,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9151,1,4,0)
 ;;=4^Lipoma of Skin of Face
 ;;^UTILITY(U,$J,358.3,9151,1,5,0)
 ;;=5^214.0
 ;;^UTILITY(U,$J,358.3,9151,2)
 ;;=Lipoma of Skin of Face^267614
 ;;^UTILITY(U,$J,358.3,9152,0)
 ;;=250.80^^61^639^36
 ;;^UTILITY(U,$J,358.3,9152,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9152,1,4,0)
 ;;=4^Ulcer, Diabetic of Toe
 ;;^UTILITY(U,$J,358.3,9152,1,5,0)
 ;;=5^250.80
 ;;^UTILITY(U,$J,358.3,9152,2)
 ;;=Ulcer, Diabetic of Toe^267846^707.15
 ;;^UTILITY(U,$J,358.3,9153,0)
 ;;=682.0^^61^639^4
 ;;^UTILITY(U,$J,358.3,9153,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9153,1,4,0)
 ;;=4^Cellulitis, Face