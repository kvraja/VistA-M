IBDEI0DR ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6620,1,4,0)
 ;;=4^780.57
 ;;^UTILITY(U,$J,358.3,6620,1,5,0)
 ;;=5^Sleep Apnea
 ;;^UTILITY(U,$J,358.3,6620,2)
 ;;=Sleep Apnea^293933
 ;;^UTILITY(U,$J,358.3,6621,0)
 ;;=786.1^^55^569^36
 ;;^UTILITY(U,$J,358.3,6621,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6621,1,4,0)
 ;;=4^786.1
 ;;^UTILITY(U,$J,358.3,6621,1,5,0)
 ;;=5^Stridor
 ;;^UTILITY(U,$J,358.3,6621,2)
 ;;=Stridor^114767
 ;;^UTILITY(U,$J,358.3,6622,0)
 ;;=011.90^^55^569^37
 ;;^UTILITY(U,$J,358.3,6622,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6622,1,4,0)
 ;;=4^011.90
 ;;^UTILITY(U,$J,358.3,6622,1,5,0)
 ;;=5^TB, Pulmonary, NOS
 ;;^UTILITY(U,$J,358.3,6622,2)
 ;;=TB, Pulmonary^122756
 ;;^UTILITY(U,$J,358.3,6623,0)
 ;;=786.06^^55^569^38
 ;;^UTILITY(U,$J,358.3,6623,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6623,1,4,0)
 ;;=4^786.06
 ;;^UTILITY(U,$J,358.3,6623,1,5,0)
 ;;=5^Tachypnea
 ;;^UTILITY(U,$J,358.3,6623,2)
 ;;=Tachypnea^321213
 ;;^UTILITY(U,$J,358.3,6624,0)
 ;;=305.1^^55^569^39
 ;;^UTILITY(U,$J,358.3,6624,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6624,1,4,0)
 ;;=4^305.1
 ;;^UTILITY(U,$J,358.3,6624,1,5,0)
 ;;=5^Tobacco Use
 ;;^UTILITY(U,$J,358.3,6624,2)
 ;;=Tobacco Use^119899
 ;;^UTILITY(U,$J,358.3,6625,0)
 ;;=786.07^^55^569^40
 ;;^UTILITY(U,$J,358.3,6625,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6625,1,4,0)
 ;;=4^786.07
 ;;^UTILITY(U,$J,358.3,6625,1,5,0)
 ;;=5^Wheezing
 ;;^UTILITY(U,$J,358.3,6625,2)
 ;;=Wheezing^127848
 ;;^UTILITY(U,$J,358.3,6626,0)
 ;;=519.11^^55^569^4
 ;;^UTILITY(U,$J,358.3,6626,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6626,1,4,0)
 ;;=4^519.11
 ;;^UTILITY(U,$J,358.3,6626,1,5,0)
 ;;=5^Acute Bronchospasm
 ;;^UTILITY(U,$J,358.3,6626,2)
 ;;=^334092
 ;;^UTILITY(U,$J,358.3,6627,0)
 ;;=488.01^^55^569^20
 ;;^UTILITY(U,$J,358.3,6627,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6627,1,4,0)
 ;;=4^488.01
 ;;^UTILITY(U,$J,358.3,6627,1,5,0)
 ;;=5^Flu DT Iden AVIAN w Pneu
 ;;^UTILITY(U,$J,358.3,6627,2)
 ;;=^339615
 ;;^UTILITY(U,$J,358.3,6628,0)
 ;;=488.02^^55^569^19
 ;;^UTILITY(U,$J,358.3,6628,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6628,1,4,0)
 ;;=4^488.02
 ;;^UTILITY(U,$J,358.3,6628,1,5,0)
 ;;=5^Flu DT AVIAN w oth Resp
 ;;^UTILITY(U,$J,358.3,6628,2)
 ;;=^339616
 ;;^UTILITY(U,$J,358.3,6629,0)
 ;;=488.09^^55^569^18
 ;;^UTILITY(U,$J,358.3,6629,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6629,1,4,0)
 ;;=4^488.09
 ;;^UTILITY(U,$J,358.3,6629,1,5,0)
 ;;=5^Flu DT AVIAN Manfest
 ;;^UTILITY(U,$J,358.3,6629,2)
 ;;=^339617
 ;;^UTILITY(U,$J,358.3,6630,0)
 ;;=786.30^^55^569^22
 ;;^UTILITY(U,$J,358.3,6630,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6630,1,4,0)
 ;;=4^786.30
 ;;^UTILITY(U,$J,358.3,6630,1,5,0)
 ;;=5^Hemoptysis
 ;;^UTILITY(U,$J,358.3,6630,2)
 ;;=^339669
 ;;^UTILITY(U,$J,358.3,6631,0)
 ;;=793.11^^55^569^1
 ;;^UTILITY(U,$J,358.3,6631,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6631,1,4,0)
 ;;=4^793.11
 ;;^UTILITY(U,$J,358.3,6631,1,5,0)
 ;;=5^Abn Chest Xray, Lung, Solitary Nodule
 ;;^UTILITY(U,$J,358.3,6631,2)
 ;;=^340570
 ;;^UTILITY(U,$J,358.3,6632,0)
 ;;=793.19^^55^569^2
 ;;^UTILITY(U,$J,358.3,6632,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6632,1,4,0)
 ;;=4^793.19
 ;;^UTILITY(U,$J,358.3,6632,1,5,0)
 ;;=5^Abn Chest Xray,Oth Finding, Lung
 ;;^UTILITY(U,$J,358.3,6632,2)
 ;;=^340571
 ;;^UTILITY(U,$J,358.3,6633,0)
 ;;=795.51^^55^569^32
 ;;^UTILITY(U,$J,358.3,6633,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6633,1,4,0)
 ;;=4^795.51
 ;;^UTILITY(U,$J,358.3,6633,1,5,0)
 ;;=5^Pos PPD w/o Active TB
 ;;^UTILITY(U,$J,358.3,6633,2)
 ;;=^340572
 ;;^UTILITY(U,$J,358.3,6634,0)
 ;;=795.52^^55^569^31
 ;;^UTILITY(U,$J,358.3,6634,1,0)
 ;;=^358.31IA^5^2