IBDEI0DD ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6424,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6424,1,2,0)
 ;;=2^12037
 ;;^UTILITY(U,$J,358.3,6424,1,3,0)
 ;;=3^INTERMED REPAIR 30+CM
 ;;^UTILITY(U,$J,358.3,6425,0)
 ;;=12051^^53^560^1^^^^1
 ;;^UTILITY(U,$J,358.3,6425,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6425,1,2,0)
 ;;=2^12051
 ;;^UTILITY(U,$J,358.3,6425,1,3,0)
 ;;=3^INTERMED REPAIR < 2.5CM
 ;;^UTILITY(U,$J,358.3,6426,0)
 ;;=12052^^53^560^2^^^^1
 ;;^UTILITY(U,$J,358.3,6426,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6426,1,2,0)
 ;;=2^12052
 ;;^UTILITY(U,$J,358.3,6426,1,3,0)
 ;;=3^INTERMED REPAIR 2.6-5CM
 ;;^UTILITY(U,$J,358.3,6427,0)
 ;;=12053^^53^560^3^^^^1
 ;;^UTILITY(U,$J,358.3,6427,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6427,1,2,0)
 ;;=2^12053
 ;;^UTILITY(U,$J,358.3,6427,1,3,0)
 ;;=3^INTERMED REPAIR 5.1-7.5CM
 ;;^UTILITY(U,$J,358.3,6428,0)
 ;;=12054^^53^560^4^^^^1
 ;;^UTILITY(U,$J,358.3,6428,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6428,1,2,0)
 ;;=2^12054
 ;;^UTILITY(U,$J,358.3,6428,1,3,0)
 ;;=3^INTERMED REPAIR 7.6-12.5CM
 ;;^UTILITY(U,$J,358.3,6429,0)
 ;;=12055^^53^560^5^^^^1
 ;;^UTILITY(U,$J,358.3,6429,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6429,1,2,0)
 ;;=2^12055
 ;;^UTILITY(U,$J,358.3,6429,1,3,0)
 ;;=3^INTERMED REPAIR 12.6-20CM
 ;;^UTILITY(U,$J,358.3,6430,0)
 ;;=12056^^53^560^6^^^^1
 ;;^UTILITY(U,$J,358.3,6430,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6430,1,2,0)
 ;;=2^12056
 ;;^UTILITY(U,$J,358.3,6430,1,3,0)
 ;;=3^INTERMED REPAIR 20.1-30CM
 ;;^UTILITY(U,$J,358.3,6431,0)
 ;;=12057^^53^560^7^^^^1
 ;;^UTILITY(U,$J,358.3,6431,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6431,1,2,0)
 ;;=2^12057
 ;;^UTILITY(U,$J,358.3,6431,1,3,0)
 ;;=3^INTERMED REPAIR 30+CM
 ;;^UTILITY(U,$J,358.3,6432,0)
 ;;=12041^^53^561^1^^^^1
 ;;^UTILITY(U,$J,358.3,6432,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6432,1,2,0)
 ;;=2^12041
 ;;^UTILITY(U,$J,358.3,6432,1,3,0)
 ;;=3^INTERMED REPAIR < 2.5CM
 ;;^UTILITY(U,$J,358.3,6433,0)
 ;;=12042^^53^561^2^^^^1
 ;;^UTILITY(U,$J,358.3,6433,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6433,1,2,0)
 ;;=2^12042
 ;;^UTILITY(U,$J,358.3,6433,1,3,0)
 ;;=3^INTERMED REPAIR 2.6-7.5CM
 ;;^UTILITY(U,$J,358.3,6434,0)
 ;;=12044^^53^561^3^^^^1
 ;;^UTILITY(U,$J,358.3,6434,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6434,1,2,0)
 ;;=2^12044
 ;;^UTILITY(U,$J,358.3,6434,1,3,0)
 ;;=3^INTERMED REPAIR 7.6-12.5CM
 ;;^UTILITY(U,$J,358.3,6435,0)
 ;;=12045^^53^561^4^^^^1
 ;;^UTILITY(U,$J,358.3,6435,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6435,1,2,0)
 ;;=2^12045
 ;;^UTILITY(U,$J,358.3,6435,1,3,0)
 ;;=3^INTERMED REPAIR 12.6-20CM
 ;;^UTILITY(U,$J,358.3,6436,0)
 ;;=12046^^53^561^5^^^^1
 ;;^UTILITY(U,$J,358.3,6436,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6436,1,2,0)
 ;;=2^12046
 ;;^UTILITY(U,$J,358.3,6436,1,3,0)
 ;;=3^INTERMED REPAIR 20.1-30CM
 ;;^UTILITY(U,$J,358.3,6437,0)
 ;;=12047^^53^561^6^^^^1
 ;;^UTILITY(U,$J,358.3,6437,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6437,1,2,0)
 ;;=2^12047
 ;;^UTILITY(U,$J,358.3,6437,1,3,0)
 ;;=3^INTERMED REPAIR 30+CM
 ;;^UTILITY(U,$J,358.3,6438,0)
 ;;=16000^^53^562^1^^^^1
 ;;^UTILITY(U,$J,358.3,6438,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6438,1,2,0)
 ;;=2^16000
 ;;^UTILITY(U,$J,358.3,6438,1,3,0)
 ;;=3^INITIAL TXMT,1ST DEGREE BURN
 ;;^UTILITY(U,$J,358.3,6439,0)
 ;;=16020^^53^562^2^^^^1
 ;;^UTILITY(U,$J,358.3,6439,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,6439,1,2,0)
 ;;=2^16020
 ;;^UTILITY(U,$J,358.3,6439,1,3,0)
 ;;=3^DRESS/DEBRID PART THICK,INIT/SUB SMALL (<5%)
 ;;^UTILITY(U,$J,358.3,6440,0)
 ;;=16025^^53^562^3^^^^1
 ;;^UTILITY(U,$J,358.3,6440,1,0)
 ;;=^358.31IA^3^2