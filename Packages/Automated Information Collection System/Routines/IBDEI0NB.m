IBDEI0NB ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,11470,1,2,0)
 ;;=2^CHOLECYSTITIS W/CAL GB & BD
 ;;^UTILITY(U,$J,358.3,11470,2)
 ;;=^304314
 ;;^UTILITY(U,$J,358.3,11471,0)
 ;;=571.2^^76^752^7
 ;;^UTILITY(U,$J,358.3,11471,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11471,1,1,0)
 ;;=1^571.2
 ;;^UTILITY(U,$J,358.3,11471,1,2,0)
 ;;=2^CIRRHOSIS,ALCOHOLIC
 ;;^UTILITY(U,$J,358.3,11471,2)
 ;;=^71505
 ;;^UTILITY(U,$J,358.3,11472,0)
 ;;=571.5^^76^752^8
 ;;^UTILITY(U,$J,358.3,11472,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11472,1,1,0)
 ;;=1^571.5
 ;;^UTILITY(U,$J,358.3,11472,1,2,0)
 ;;=2^CIRRHOSIS,NON-ALCOHOLIC
 ;;^UTILITY(U,$J,358.3,11472,2)
 ;;=^24731
 ;;^UTILITY(U,$J,358.3,11473,0)
 ;;=555.9^^76^752^9
 ;;^UTILITY(U,$J,358.3,11473,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11473,1,1,0)
 ;;=1^555.9
 ;;^UTILITY(U,$J,358.3,11473,1,2,0)
 ;;=2^CROHN'S DISEASE
 ;;^UTILITY(U,$J,358.3,11473,2)
 ;;=^29356
 ;;^UTILITY(U,$J,358.3,11474,0)
 ;;=578.9^^76^752^10
 ;;^UTILITY(U,$J,358.3,11474,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11474,1,1,0)
 ;;=1^578.9
 ;;^UTILITY(U,$J,358.3,11474,1,2,0)
 ;;=2^GASTROINTEST HEMORR NOS
 ;;^UTILITY(U,$J,358.3,11474,2)
 ;;=^49525
 ;;^UTILITY(U,$J,358.3,11475,0)
 ;;=572.2^^76^752^11
 ;;^UTILITY(U,$J,358.3,11475,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11475,1,1,0)
 ;;=1^572.2
 ;;^UTILITY(U,$J,358.3,11475,1,2,0)
 ;;=2^HEPATIC ENCEPHALOPATHY
 ;;^UTILITY(U,$J,358.3,11475,2)
 ;;=^338527
 ;;^UTILITY(U,$J,358.3,11476,0)
 ;;=573.4^^76^752^12
 ;;^UTILITY(U,$J,358.3,11476,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11476,1,1,0)
 ;;=1^573.4
 ;;^UTILITY(U,$J,358.3,11476,1,2,0)
 ;;=2^HEPATIC INFARCTION
 ;;^UTILITY(U,$J,358.3,11476,2)
 ;;=^276862
 ;;^UTILITY(U,$J,358.3,11477,0)
 ;;=570.^^76^752^13
 ;;^UTILITY(U,$J,358.3,11477,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11477,1,1,0)
 ;;=1^570.
 ;;^UTILITY(U,$J,358.3,11477,1,2,0)
 ;;=2^HEPATIC NECROSIS
 ;;^UTILITY(U,$J,358.3,11477,2)
 ;;=^2603
 ;;^UTILITY(U,$J,358.3,11478,0)
 ;;=572.4^^76^752^14
 ;;^UTILITY(U,$J,358.3,11478,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11478,1,1,0)
 ;;=1^572.4
 ;;^UTILITY(U,$J,358.3,11478,1,2,0)
 ;;=2^HEPATORENAL SYNDROME
 ;;^UTILITY(U,$J,358.3,11478,2)
 ;;=^56497
 ;;^UTILITY(U,$J,358.3,11479,0)
 ;;=557.9^^76^752^15
 ;;^UTILITY(U,$J,358.3,11479,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11479,1,1,0)
 ;;=1^557.9
 ;;^UTILITY(U,$J,358.3,11479,1,2,0)
 ;;=2^INTEST ISCHEMIA & INFARCTION
 ;;^UTILITY(U,$J,358.3,11479,2)
 ;;=^270252
 ;;^UTILITY(U,$J,358.3,11480,0)
 ;;=577.0^^76^752^16
 ;;^UTILITY(U,$J,358.3,11480,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11480,1,1,0)
 ;;=1^577.0
 ;;^UTILITY(U,$J,358.3,11480,1,2,0)
 ;;=2^PANCREATITIS
 ;;^UTILITY(U,$J,358.3,11480,2)
 ;;=^2643
 ;;^UTILITY(U,$J,358.3,11481,0)
 ;;=567.9^^76^752^17
 ;;^UTILITY(U,$J,358.3,11481,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11481,1,1,0)
 ;;=1^567.9
 ;;^UTILITY(U,$J,358.3,11481,1,2,0)
 ;;=2^PERITONITIS NOS
 ;;^UTILITY(U,$J,358.3,11481,2)
 ;;=^92323
 ;;^UTILITY(U,$J,358.3,11482,0)
 ;;=452.^^76^752^18
 ;;^UTILITY(U,$J,358.3,11482,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11482,1,1,0)
 ;;=1^452.
 ;;^UTILITY(U,$J,358.3,11482,1,2,0)
 ;;=2^PORTAL VEIN THROMBOSIS
 ;;^UTILITY(U,$J,358.3,11482,2)
 ;;=^269815
 ;;^UTILITY(U,$J,358.3,11483,0)
 ;;=556.9^^76^752^19
 ;;^UTILITY(U,$J,358.3,11483,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11483,1,1,0)
 ;;=1^556.9
 ;;^UTILITY(U,$J,358.3,11483,1,2,0)
 ;;=2^ULCERATIVE COLITIS
 ;;^UTILITY(U,$J,358.3,11483,2)
 ;;=^26044
 ;;^UTILITY(U,$J,358.3,11484,0)
 ;;=569.9^^76^752^20
 ;;^UTILITY(U,$J,358.3,11484,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,11484,1,1,0)
 ;;=1^569.9