IBDEI0XP ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,16720,1,3,0)
 ;;=3^642.63
 ;;^UTILITY(U,$J,358.3,16720,1,4,0)
 ;;=4^Eclampsia-Antepartum
 ;;^UTILITY(U,$J,358.3,16720,2)
 ;;=^270851
 ;;^UTILITY(U,$J,358.3,16721,0)
 ;;=642.64^^108^1049^4
 ;;^UTILITY(U,$J,358.3,16721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16721,1,3,0)
 ;;=3^642.64
 ;;^UTILITY(U,$J,358.3,16721,1,4,0)
 ;;=4^Eclampsia-Postpartum
 ;;^UTILITY(U,$J,358.3,16721,2)
 ;;=^270852
 ;;^UTILITY(U,$J,358.3,16722,0)
 ;;=642.73^^108^1049^13
 ;;^UTILITY(U,$J,358.3,16722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16722,1,3,0)
 ;;=3^642.73
 ;;^UTILITY(U,$J,358.3,16722,1,4,0)
 ;;=4^Tox w old HTN-Antepartum
 ;;^UTILITY(U,$J,358.3,16722,2)
 ;;=^270857
 ;;^UTILITY(U,$J,358.3,16723,0)
 ;;=642.74^^108^1049^14
 ;;^UTILITY(U,$J,358.3,16723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16723,1,3,0)
 ;;=3^642.74
 ;;^UTILITY(U,$J,358.3,16723,1,4,0)
 ;;=4^Tox w old HTN-Postpartum
 ;;^UTILITY(U,$J,358.3,16723,2)
 ;;=^270858
 ;;^UTILITY(U,$J,358.3,16724,0)
 ;;=675.03^^108^1050^11
 ;;^UTILITY(U,$J,358.3,16724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16724,1,3,0)
 ;;=3^675.03
 ;;^UTILITY(U,$J,358.3,16724,1,4,0)
 ;;=4^Infection nipple-Antepartum
 ;;^UTILITY(U,$J,358.3,16724,2)
 ;;=^271795
 ;;^UTILITY(U,$J,358.3,16725,0)
 ;;=675.04^^108^1050^12
 ;;^UTILITY(U,$J,358.3,16725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16725,1,3,0)
 ;;=3^675.04
 ;;^UTILITY(U,$J,358.3,16725,1,4,0)
 ;;=4^Infection nipple-Postpartum
 ;;^UTILITY(U,$J,358.3,16725,2)
 ;;=^271796
 ;;^UTILITY(U,$J,358.3,16726,0)
 ;;=675.13^^108^1050^1
 ;;^UTILITY(U,$J,358.3,16726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16726,1,3,0)
 ;;=3^675.13
 ;;^UTILITY(U,$J,358.3,16726,1,4,0)
 ;;=4^Abscess breast-Antepartum
 ;;^UTILITY(U,$J,358.3,16726,2)
 ;;=^271801
 ;;^UTILITY(U,$J,358.3,16727,0)
 ;;=675.14^^108^1050^2
 ;;^UTILITY(U,$J,358.3,16727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16727,1,3,0)
 ;;=3^675.14
 ;;^UTILITY(U,$J,358.3,16727,1,4,0)
 ;;=4^Abscess breast-Postpartum
 ;;^UTILITY(U,$J,358.3,16727,2)
 ;;=^271802
 ;;^UTILITY(U,$J,358.3,16728,0)
 ;;=675.23^^108^1050^13
 ;;^UTILITY(U,$J,358.3,16728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16728,1,3,0)
 ;;=3^675.23
 ;;^UTILITY(U,$J,358.3,16728,1,4,0)
 ;;=4^Mastitis-Antepartum
 ;;^UTILITY(U,$J,358.3,16728,2)
 ;;=^271807
 ;;^UTILITY(U,$J,358.3,16729,0)
 ;;=675.24^^108^1050^14
 ;;^UTILITY(U,$J,358.3,16729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16729,1,3,0)
 ;;=3^675.24
 ;;^UTILITY(U,$J,358.3,16729,1,4,0)
 ;;=4^Mastitis-Postpartum
 ;;^UTILITY(U,$J,358.3,16729,2)
 ;;=^271808
 ;;^UTILITY(U,$J,358.3,16730,0)
 ;;=676.03^^108^1050^15
 ;;^UTILITY(U,$J,358.3,16730,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16730,1,3,0)
 ;;=3^676.03
 ;;^UTILITY(U,$J,358.3,16730,1,4,0)
 ;;=4^Retracted nipple-Antepartum
 ;;^UTILITY(U,$J,358.3,16730,2)
 ;;=^271826
 ;;^UTILITY(U,$J,358.3,16731,0)
 ;;=676.04^^108^1050^16
 ;;^UTILITY(U,$J,358.3,16731,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16731,1,3,0)
 ;;=3^676.04
 ;;^UTILITY(U,$J,358.3,16731,1,4,0)
 ;;=4^Retracted nipple-Postpartum
 ;;^UTILITY(U,$J,358.3,16731,2)
 ;;=^271827
 ;;^UTILITY(U,$J,358.3,16732,0)
 ;;=676.13^^108^1050^3
 ;;^UTILITY(U,$J,358.3,16732,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16732,1,3,0)
 ;;=3^676.13
 ;;^UTILITY(U,$J,358.3,16732,1,4,0)
 ;;=4^Cracked nipple-Antepartum
 ;;^UTILITY(U,$J,358.3,16732,2)
 ;;=^271832
 ;;^UTILITY(U,$J,358.3,16733,0)
 ;;=676.14^^108^1050^4
 ;;^UTILITY(U,$J,358.3,16733,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,16733,1,3,0)
 ;;=3^676.14
 ;;^UTILITY(U,$J,358.3,16733,1,4,0)
 ;;=4^Cracked nipple-Postpartum