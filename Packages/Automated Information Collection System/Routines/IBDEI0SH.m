IBDEI0SH ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14062,0)
 ;;=289.51^^90^855^90
 ;;^UTILITY(U,$J,358.3,14062,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14062,1,4,0)
 ;;=4^289.51
 ;;^UTILITY(U,$J,358.3,14062,1,5,0)
 ;;=5^Splenomegaly, Chronic
 ;;^UTILITY(U,$J,358.3,14062,2)
 ;;=^268000
 ;;^UTILITY(U,$J,358.3,14063,0)
 ;;=556.9^^90^855^91
 ;;^UTILITY(U,$J,358.3,14063,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14063,1,4,0)
 ;;=4^556.9
 ;;^UTILITY(U,$J,358.3,14063,1,5,0)
 ;;=5^Ulcerative Colitis
 ;;^UTILITY(U,$J,358.3,14063,2)
 ;;=^26044
 ;;^UTILITY(U,$J,358.3,14064,0)
 ;;=787.03^^90^855^92
 ;;^UTILITY(U,$J,358.3,14064,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14064,1,4,0)
 ;;=4^787.03
 ;;^UTILITY(U,$J,358.3,14064,1,5,0)
 ;;=5^Vomiting Alone
 ;;^UTILITY(U,$J,358.3,14064,2)
 ;;=^127237
 ;;^UTILITY(U,$J,358.3,14065,0)
 ;;=789.07^^90^855^46
 ;;^UTILITY(U,$J,358.3,14065,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14065,1,4,0)
 ;;=4^789.07
 ;;^UTILITY(U,$J,358.3,14065,1,5,0)
 ;;=5^Generalized Abdominal Pain
 ;;^UTILITY(U,$J,358.3,14065,2)
 ;;=Generalized Abdominal Pain^303324
 ;;^UTILITY(U,$J,358.3,14066,0)
 ;;=564.00^^90^855^12
 ;;^UTILITY(U,$J,358.3,14066,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14066,1,4,0)
 ;;=4^564.00
 ;;^UTILITY(U,$J,358.3,14066,1,5,0)
 ;;=5^Constipation
 ;;^UTILITY(U,$J,358.3,14066,2)
 ;;=Constipation^323537
 ;;^UTILITY(U,$J,358.3,14067,0)
 ;;=V18.51^^90^855^34
 ;;^UTILITY(U,$J,358.3,14067,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14067,1,4,0)
 ;;=4^V18.51
 ;;^UTILITY(U,$J,358.3,14067,1,5,0)
 ;;=5^Family hx Colonic Polyps
 ;;^UTILITY(U,$J,358.3,14067,2)
 ;;=^334209
 ;;^UTILITY(U,$J,358.3,14068,0)
 ;;=V18.59^^90^855^35
 ;;^UTILITY(U,$J,358.3,14068,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14068,1,4,0)
 ;;=4^V18.59
 ;;^UTILITY(U,$J,358.3,14068,1,5,0)
 ;;=5^Family hx Other GI Problems
 ;;^UTILITY(U,$J,358.3,14068,2)
 ;;=^334210
 ;;^UTILITY(U,$J,358.3,14069,0)
 ;;=787.20^^90^855^19
 ;;^UTILITY(U,$J,358.3,14069,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14069,1,4,0)
 ;;=4^787.20
 ;;^UTILITY(U,$J,358.3,14069,1,5,0)
 ;;=5^Dysphagia
 ;;^UTILITY(U,$J,358.3,14069,2)
 ;;=^335307
 ;;^UTILITY(U,$J,358.3,14070,0)
 ;;=789.59^^90^855^4
 ;;^UTILITY(U,$J,358.3,14070,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14070,1,4,0)
 ;;=4^789.59
 ;;^UTILITY(U,$J,358.3,14070,1,5,0)
 ;;=5^Ascites
 ;;^UTILITY(U,$J,358.3,14070,2)
 ;;=^335282
 ;;^UTILITY(U,$J,358.3,14071,0)
 ;;=533.90^^90^855^76
 ;;^UTILITY(U,$J,358.3,14071,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14071,1,4,0)
 ;;=4^533.90
 ;;^UTILITY(U,$J,358.3,14071,1,5,0)
 ;;=5^PUD
 ;;^UTILITY(U,$J,358.3,14071,2)
 ;;=^93051
 ;;^UTILITY(U,$J,358.3,14072,0)
 ;;=790.6^^90^855^3
 ;;^UTILITY(U,$J,358.3,14072,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14072,1,4,0)
 ;;=4^790.6
 ;;^UTILITY(U,$J,358.3,14072,1,5,0)
 ;;=5^Abnormal LFT's
 ;;^UTILITY(U,$J,358.3,14072,2)
 ;;=Abnormal LFT's^87228
 ;;^UTILITY(U,$J,358.3,14073,0)
 ;;=V12.72^^90^855^65
 ;;^UTILITY(U,$J,358.3,14073,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14073,1,4,0)
 ;;=4^V12.72
 ;;^UTILITY(U,$J,358.3,14073,1,5,0)
 ;;=5^Hx of Colon Polyps
 ;;^UTILITY(U,$J,358.3,14073,2)
 ;;=^303401
 ;;^UTILITY(U,$J,358.3,14074,0)
 ;;=530.13^^90^855^33
 ;;^UTILITY(U,$J,358.3,14074,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14074,1,4,0)
 ;;=4^530.13
 ;;^UTILITY(U,$J,358.3,14074,1,5,0)
 ;;=5^Esophagitis,Eosinophilic
 ;;^UTILITY(U,$J,358.3,14074,2)
 ;;=^336605
 ;;^UTILITY(U,$J,358.3,14075,0)
 ;;=535.70^^90^855^45
 ;;^UTILITY(U,$J,358.3,14075,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,14075,1,4,0)
 ;;=4^535.70
 ;;^UTILITY(U,$J,358.3,14075,1,5,0)
 ;;=5^Gastritis,Eosinophilic w/o Hemorrhage