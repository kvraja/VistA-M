IBDEI0HZ ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8746,1,4,0)
 ;;=4^26011
 ;;^UTILITY(U,$J,358.3,8747,0)
 ;;=26020^^60^618^6
 ;;^UTILITY(U,$J,358.3,8747,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8747,1,2,0)
 ;;=2^Drain Tendon Sheath,Ea Hand
 ;;^UTILITY(U,$J,358.3,8747,1,4,0)
 ;;=4^26020
 ;;^UTILITY(U,$J,358.3,8748,0)
 ;;=10120^^60^618^16
 ;;^UTILITY(U,$J,358.3,8748,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8748,1,2,0)
 ;;=2^Removal,foreign body,simple
 ;;^UTILITY(U,$J,358.3,8748,1,4,0)
 ;;=4^10120
 ;;^UTILITY(U,$J,358.3,8749,0)
 ;;=10121^^60^618^15
 ;;^UTILITY(U,$J,358.3,8749,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8749,1,2,0)
 ;;=2^Removal,foreign body,complex
 ;;^UTILITY(U,$J,358.3,8749,1,4,0)
 ;;=4^10121
 ;;^UTILITY(U,$J,358.3,8750,0)
 ;;=26010^^60^618^5^^^^1
 ;;^UTILITY(U,$J,358.3,8750,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8750,1,2,0)
 ;;=2^Drain abscess finger,simple
 ;;^UTILITY(U,$J,358.3,8750,1,4,0)
 ;;=4^26010
 ;;^UTILITY(U,$J,358.3,8751,0)
 ;;=10180^^60^618^10^^^^1
 ;;^UTILITY(U,$J,358.3,8751,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8751,1,2,0)
 ;;=2^I&D complex postop wound
 ;;^UTILITY(U,$J,358.3,8751,1,4,0)
 ;;=4^10180
 ;;^UTILITY(U,$J,358.3,8752,0)
 ;;=10080^^60^618^3^^^^1
 ;;^UTILITY(U,$J,358.3,8752,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8752,1,2,0)
 ;;=2^Drain Pilonidal Cyst
 ;;^UTILITY(U,$J,358.3,8752,1,4,0)
 ;;=4^10080
 ;;^UTILITY(U,$J,358.3,8753,0)
 ;;=10021^^60^618^7^^^^1
 ;;^UTILITY(U,$J,358.3,8753,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8753,1,2,0)
 ;;=2^FNA w/o Image
 ;;^UTILITY(U,$J,358.3,8753,1,4,0)
 ;;=4^10021
 ;;^UTILITY(U,$J,358.3,8754,0)
 ;;=10030^^60^618^12^^^^1
 ;;^UTILITY(U,$J,358.3,8754,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8754,1,2,0)
 ;;=2^Image-Guide Coll by Cath Absc
 ;;^UTILITY(U,$J,358.3,8754,1,4,0)
 ;;=4^10030
 ;;^UTILITY(U,$J,358.3,8755,0)
 ;;=19020^^60^618^13^^^^1
 ;;^UTILITY(U,$J,358.3,8755,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8755,1,2,0)
 ;;=2^Mastotomy w/Exp/Drng Absc Deep
 ;;^UTILITY(U,$J,358.3,8755,1,4,0)
 ;;=4^19020
 ;;^UTILITY(U,$J,358.3,8756,0)
 ;;=17000^^60^619^1
 ;;^UTILITY(U,$J,358.3,8756,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8756,1,2,0)
 ;;=2^Single lesion,skin,any method
 ;;^UTILITY(U,$J,358.3,8756,1,4,0)
 ;;=4^17000
 ;;^UTILITY(U,$J,358.3,8757,0)
 ;;=11200^^60^619^4
 ;;^UTILITY(U,$J,358.3,8757,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8757,1,2,0)
 ;;=2^Skin tags, 1-15, any method
 ;;^UTILITY(U,$J,358.3,8757,1,4,0)
 ;;=4^11200
 ;;^UTILITY(U,$J,358.3,8758,0)
 ;;=17003^^60^619^2^^^^1
 ;;^UTILITY(U,$J,358.3,8758,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8758,1,2,0)
 ;;=2^2-14 lesions,any method
 ;;^UTILITY(U,$J,358.3,8758,1,4,0)
 ;;=4^17003
 ;;^UTILITY(U,$J,358.3,8759,0)
 ;;=17004^^60^619^3^^^^1
 ;;^UTILITY(U,$J,358.3,8759,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8759,1,2,0)
 ;;=2^15 or more lesions, any method
 ;;^UTILITY(U,$J,358.3,8759,1,4,0)
 ;;=4^17004
 ;;^UTILITY(U,$J,358.3,8760,0)
 ;;=92511^^60^620^3^^^^1
 ;;^UTILITY(U,$J,358.3,8760,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8760,1,2,0)
 ;;=2^Nasopharyngoscopy
 ;;^UTILITY(U,$J,358.3,8760,1,4,0)
 ;;=4^92511
 ;;^UTILITY(U,$J,358.3,8761,0)
 ;;=46606^^60^620^1^^^^1
 ;;^UTILITY(U,$J,358.3,8761,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8761,1,2,0)
 ;;=2^Anoscopy w/ Biopsy
 ;;^UTILITY(U,$J,358.3,8761,1,4,0)
 ;;=4^46606
 ;;^UTILITY(U,$J,358.3,8762,0)
 ;;=46600^^60^620^2^^^^1
 ;;^UTILITY(U,$J,358.3,8762,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8762,1,2,0)
 ;;=2^Anoscopy,Diagnostic
 ;;^UTILITY(U,$J,358.3,8762,1,4,0)
 ;;=4^46600
 ;;^UTILITY(U,$J,358.3,8763,0)
 ;;=45305^^60^620^4^^^^1