IBDEI18Q ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22201,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22201,1,2,0)
 ;;=2^US LF Non-Contact Non-Therm,Wnd Assess
 ;;^UTILITY(U,$J,358.3,22201,1,3,0)
 ;;=3^97610
 ;;^UTILITY(U,$J,358.3,22202,0)
 ;;=93797^^135^1337^2^^^^1
 ;;^UTILITY(U,$J,358.3,22202,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22202,1,2,0)
 ;;=2^Cardiac Rehab w/o Contin ECG Monitor
 ;;^UTILITY(U,$J,358.3,22202,1,3,0)
 ;;=3^93797
 ;;^UTILITY(U,$J,358.3,22203,0)
 ;;=93798^^135^1337^1^^^^1
 ;;^UTILITY(U,$J,358.3,22203,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22203,1,2,0)
 ;;=2^Cardiac Rehab w/Contin ECG Monitor
 ;;^UTILITY(U,$J,358.3,22203,1,3,0)
 ;;=3^93798
 ;;^UTILITY(U,$J,358.3,22204,0)
 ;;=98960^^135^1338^3^^^^1
 ;;^UTILITY(U,$J,358.3,22204,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22204,1,2,0)
 ;;=2^Ed/Train Self-Mgmt nonphy;1 pt ea 30min
 ;;^UTILITY(U,$J,358.3,22204,1,3,0)
 ;;=3^98960
 ;;^UTILITY(U,$J,358.3,22205,0)
 ;;=98961^^135^1338^1^^^^1
 ;;^UTILITY(U,$J,358.3,22205,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22205,1,2,0)
 ;;=2^Ed/Train Self-Mgmt HCP;2-4 pts ea 30min
 ;;^UTILITY(U,$J,358.3,22205,1,3,0)
 ;;=3^98961
 ;;^UTILITY(U,$J,358.3,22206,0)
 ;;=98962^^135^1338^2^^^^1
 ;;^UTILITY(U,$J,358.3,22206,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22206,1,2,0)
 ;;=2^Ed/Train Self-Mgmt HCP;5-8 pts ea 30min
 ;;^UTILITY(U,$J,358.3,22206,1,3,0)
 ;;=3^98962
 ;;^UTILITY(U,$J,358.3,22207,0)
 ;;=98969^^135^1338^4^^^^1
 ;;^UTILITY(U,$J,358.3,22207,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22207,1,2,0)
 ;;=2^Online assess/mgmt svc by HCP;est pt
 ;;^UTILITY(U,$J,358.3,22207,1,3,0)
 ;;=3^98969
 ;;^UTILITY(U,$J,358.3,22208,0)
 ;;=G0151^^135^1339^5^^^^1
 ;;^UTILITY(U,$J,358.3,22208,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22208,1,2,0)
 ;;=2^PT in home/hospice,ea 15min
 ;;^UTILITY(U,$J,358.3,22208,1,3,0)
 ;;=3^G0151
 ;;^UTILITY(U,$J,358.3,22209,0)
 ;;=G0152^^135^1339^2^^^^1
 ;;^UTILITY(U,$J,358.3,22209,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22209,1,2,0)
 ;;=2^OT in home/hospice,ea 15min
 ;;^UTILITY(U,$J,358.3,22209,1,3,0)
 ;;=3^G0152
 ;;^UTILITY(U,$J,358.3,22210,0)
 ;;=G0157^^135^1339^6^^^^1
 ;;^UTILITY(U,$J,358.3,22210,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22210,1,2,0)
 ;;=2^PTA in home/hospice,ea 15min
 ;;^UTILITY(U,$J,358.3,22210,1,3,0)
 ;;=3^G0157
 ;;^UTILITY(U,$J,358.3,22211,0)
 ;;=G0158^^135^1339^3^^^^1
 ;;^UTILITY(U,$J,358.3,22211,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22211,1,2,0)
 ;;=2^OTA in home/hospice,ea 15min
 ;;^UTILITY(U,$J,358.3,22211,1,3,0)
 ;;=3^G0158
 ;;^UTILITY(U,$J,358.3,22212,0)
 ;;=G0159^^135^1339^4^^^^1
 ;;^UTILITY(U,$J,358.3,22212,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22212,1,2,0)
 ;;=2^PT Maint in home,ea 15min
 ;;^UTILITY(U,$J,358.3,22212,1,3,0)
 ;;=3^G0159
 ;;^UTILITY(U,$J,358.3,22213,0)
 ;;=G0160^^135^1339^1^^^^1
 ;;^UTILITY(U,$J,358.3,22213,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22213,1,2,0)
 ;;=2^OT Maint in home,ea 15min
 ;;^UTILITY(U,$J,358.3,22213,1,3,0)
 ;;=3^G0160
 ;;^UTILITY(U,$J,358.3,22214,0)
 ;;=95860^^135^1340^4^^^^1
 ;;^UTILITY(U,$J,358.3,22214,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22214,1,2,0)
 ;;=2^Muscle Test (EMG),1 Limb
 ;;^UTILITY(U,$J,358.3,22214,1,3,0)
 ;;=3^95860
 ;;^UTILITY(U,$J,358.3,22215,0)
 ;;=95863^^135^1340^6^^^^1
 ;;^UTILITY(U,$J,358.3,22215,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22215,1,2,0)
 ;;=2^Muscle Test (EMG),3 Limbs
 ;;^UTILITY(U,$J,358.3,22215,1,3,0)
 ;;=3^95863
 ;;^UTILITY(U,$J,358.3,22216,0)
 ;;=95864^^135^1340^7^^^^1
 ;;^UTILITY(U,$J,358.3,22216,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,22216,1,2,0)
 ;;=2^Muscle Test (EMG),4 Limbs