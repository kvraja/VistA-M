IBDEI043 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1212,1,4,0)
 ;;=4^B35.6
 ;;^UTILITY(U,$J,358.3,1212,2)
 ;;=^119711
 ;;^UTILITY(U,$J,358.3,1213,0)
 ;;=E05.90^^12^134^2
 ;;^UTILITY(U,$J,358.3,1213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1213,1,3,0)
 ;;=3^Thyrotoxicosis w/o Thyrotoxic Crisis/Storm
 ;;^UTILITY(U,$J,358.3,1213,1,4,0)
 ;;=4^E05.90
 ;;^UTILITY(U,$J,358.3,1213,2)
 ;;=^5002492
 ;;^UTILITY(U,$J,358.3,1214,0)
 ;;=K42.9^^12^134^7
 ;;^UTILITY(U,$J,358.3,1214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1214,1,3,0)
 ;;=3^Umbilical Hernia w/o Obst/Gangr
 ;;^UTILITY(U,$J,358.3,1214,1,4,0)
 ;;=4^K42.9
 ;;^UTILITY(U,$J,358.3,1214,2)
 ;;=^5008606
 ;;^UTILITY(U,$J,358.3,1215,0)
 ;;=R00.0^^12^134^1
 ;;^UTILITY(U,$J,358.3,1215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1215,1,3,0)
 ;;=3^Tachycardia,Unspec
 ;;^UTILITY(U,$J,358.3,1215,1,4,0)
 ;;=4^R00.0
 ;;^UTILITY(U,$J,358.3,1215,2)
 ;;=^5019163
 ;;^UTILITY(U,$J,358.3,1216,0)
 ;;=B35.3^^12^134^5
 ;;^UTILITY(U,$J,358.3,1216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1216,1,3,0)
 ;;=3^Tinea Pedis
 ;;^UTILITY(U,$J,358.3,1216,1,4,0)
 ;;=4^B35.3
 ;;^UTILITY(U,$J,358.3,1216,2)
 ;;=^119732
 ;;^UTILITY(U,$J,358.3,1217,0)
 ;;=J06.9^^12^134^8
 ;;^UTILITY(U,$J,358.3,1217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1217,1,3,0)
 ;;=3^Upper Respiratory Infection,Acute
 ;;^UTILITY(U,$J,358.3,1217,1,4,0)
 ;;=4^J06.9
 ;;^UTILITY(U,$J,358.3,1217,2)
 ;;=^5008143
 ;;^UTILITY(U,$J,358.3,1218,0)
 ;;=K08.8^^12^134^6
 ;;^UTILITY(U,$J,358.3,1218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1218,1,3,0)
 ;;=3^Toothache
 ;;^UTILITY(U,$J,358.3,1218,1,4,0)
 ;;=4^K08.8
 ;;^UTILITY(U,$J,358.3,1218,2)
 ;;=^5008467
 ;;^UTILITY(U,$J,358.3,1219,0)
 ;;=N34.1^^12^134^9
 ;;^UTILITY(U,$J,358.3,1219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1219,1,3,0)
 ;;=3^Urethritis,Nonspec
 ;;^UTILITY(U,$J,358.3,1219,1,4,0)
 ;;=4^N34.1
 ;;^UTILITY(U,$J,358.3,1219,2)
 ;;=^5015655
 ;;^UTILITY(U,$J,358.3,1220,0)
 ;;=N39.0^^12^134^11
 ;;^UTILITY(U,$J,358.3,1220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1220,1,3,0)
 ;;=3^Urinary Tract Infection
 ;;^UTILITY(U,$J,358.3,1220,1,4,0)
 ;;=4^N39.0
 ;;^UTILITY(U,$J,358.3,1220,2)
 ;;=^124436
 ;;^UTILITY(U,$J,358.3,1221,0)
 ;;=R33.9^^12^134^12
 ;;^UTILITY(U,$J,358.3,1221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1221,1,3,0)
 ;;=3^Urine Retention,Unspec
 ;;^UTILITY(U,$J,358.3,1221,1,4,0)
 ;;=4^R33.9
 ;;^UTILITY(U,$J,358.3,1221,2)
 ;;=^5019332
 ;;^UTILITY(U,$J,358.3,1222,0)
 ;;=R32.^^12^134^10
 ;;^UTILITY(U,$J,358.3,1222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1222,1,3,0)
 ;;=3^Urinary Incontinence,Unspec
 ;;^UTILITY(U,$J,358.3,1222,1,4,0)
 ;;=4^R32.
 ;;^UTILITY(U,$J,358.3,1222,2)
 ;;=^5019329
 ;;^UTILITY(U,$J,358.3,1223,0)
 ;;=B97.89^^12^135^7
 ;;^UTILITY(U,$J,358.3,1223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1223,1,3,0)
 ;;=3^Viral Agents as the Cause of Diseases Classified Elsewhere
 ;;^UTILITY(U,$J,358.3,1223,1,4,0)
 ;;=4^B97.89
 ;;^UTILITY(U,$J,358.3,1223,2)
 ;;=^5000879
 ;;^UTILITY(U,$J,358.3,1224,0)
 ;;=H54.7^^12^135^8
 ;;^UTILITY(U,$J,358.3,1224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1224,1,3,0)
 ;;=3^Visual Loss,Unspec
 ;;^UTILITY(U,$J,358.3,1224,1,4,0)
 ;;=4^H54.7
 ;;^UTILITY(U,$J,358.3,1224,2)
 ;;=^5006368
 ;;^UTILITY(U,$J,358.3,1225,0)
 ;;=I83.91^^12^135^5
 ;;^UTILITY(U,$J,358.3,1225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1225,1,3,0)
 ;;=3^Varicose Veins,Asymptomatic,Right Lower Extremity
 ;;^UTILITY(U,$J,358.3,1225,1,4,0)
 ;;=4^I83.91
 ;;^UTILITY(U,$J,358.3,1225,2)
 ;;=^5008020
 ;;^UTILITY(U,$J,358.3,1226,0)
 ;;=I83.92^^12^135^4
 ;;^UTILITY(U,$J,358.3,1226,1,0)
 ;;=^358.31IA^4^2
