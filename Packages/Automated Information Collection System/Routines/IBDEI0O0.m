IBDEI0O0 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10976,0)
 ;;=Z91.041^^68^676^139
 ;;^UTILITY(U,$J,358.3,10976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10976,1,3,0)
 ;;=3^Radiographic Dye Allergy
 ;;^UTILITY(U,$J,358.3,10976,1,4,0)
 ;;=4^Z91.041
 ;;^UTILITY(U,$J,358.3,10976,2)
 ;;=^5063608
 ;;^UTILITY(U,$J,358.3,10977,0)
 ;;=Z91.130^^68^676^146
 ;;^UTILITY(U,$J,358.3,10977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10977,1,3,0)
 ;;=3^Underdose of Med Regiment d/t Age-Related Debility
 ;;^UTILITY(U,$J,358.3,10977,1,4,0)
 ;;=4^Z91.130
 ;;^UTILITY(U,$J,358.3,10977,2)
 ;;=^5063614
 ;;^UTILITY(U,$J,358.3,10978,0)
 ;;=Z91.138^^68^676^147
 ;;^UTILITY(U,$J,358.3,10978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10978,1,3,0)
 ;;=3^Underdose of Med Regiment for Other Reason
 ;;^UTILITY(U,$J,358.3,10978,1,4,0)
 ;;=4^Z91.138
 ;;^UTILITY(U,$J,358.3,10978,2)
 ;;=^5063615
 ;;^UTILITY(U,$J,358.3,10979,0)
 ;;=Z91.14^^68^676^71
 ;;^UTILITY(U,$J,358.3,10979,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10979,1,3,0)
 ;;=3^Noncompliance w/ Medication Regimen
 ;;^UTILITY(U,$J,358.3,10979,1,4,0)
 ;;=4^Z91.14
 ;;^UTILITY(U,$J,358.3,10979,2)
 ;;=^5063616
 ;;^UTILITY(U,$J,358.3,10980,0)
 ;;=Z91.19^^68^676^70
 ;;^UTILITY(U,$J,358.3,10980,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10980,1,3,0)
 ;;=3^Noncompliance w/ Medical Treatment & Regimen
 ;;^UTILITY(U,$J,358.3,10980,1,4,0)
 ;;=4^Z91.19
 ;;^UTILITY(U,$J,358.3,10980,2)
 ;;=^5063618
 ;;^UTILITY(U,$J,358.3,10981,0)
 ;;=Z93.1^^68^676^52
 ;;^UTILITY(U,$J,358.3,10981,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10981,1,3,0)
 ;;=3^Gastrostomy Status
 ;;^UTILITY(U,$J,358.3,10981,1,4,0)
 ;;=4^Z93.1
 ;;^UTILITY(U,$J,358.3,10981,2)
 ;;=^5063643
 ;;^UTILITY(U,$J,358.3,10982,0)
 ;;=Z93.2^^68^676^58
 ;;^UTILITY(U,$J,358.3,10982,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10982,1,3,0)
 ;;=3^Ileostomy Status
 ;;^UTILITY(U,$J,358.3,10982,1,4,0)
 ;;=4^Z93.2
 ;;^UTILITY(U,$J,358.3,10982,2)
 ;;=^5063644
 ;;^UTILITY(U,$J,358.3,10983,0)
 ;;=Z93.3^^68^676^15
 ;;^UTILITY(U,$J,358.3,10983,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10983,1,3,0)
 ;;=3^Colostomy Status
 ;;^UTILITY(U,$J,358.3,10983,1,4,0)
 ;;=4^Z93.3
 ;;^UTILITY(U,$J,358.3,10983,2)
 ;;=^5063645
 ;;^UTILITY(U,$J,358.3,10984,0)
 ;;=Z94.0^^68^676^63
 ;;^UTILITY(U,$J,358.3,10984,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10984,1,3,0)
 ;;=3^Kidney Transplant Status
 ;;^UTILITY(U,$J,358.3,10984,1,4,0)
 ;;=4^Z94.0
 ;;^UTILITY(U,$J,358.3,10984,2)
 ;;=^5063654
 ;;^UTILITY(U,$J,358.3,10985,0)
 ;;=Z94.1^^68^676^56
 ;;^UTILITY(U,$J,358.3,10985,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10985,1,3,0)
 ;;=3^Heart Transplant Status
 ;;^UTILITY(U,$J,358.3,10985,1,4,0)
 ;;=4^Z94.1
 ;;^UTILITY(U,$J,358.3,10985,2)
 ;;=^5063655
 ;;^UTILITY(U,$J,358.3,10986,0)
 ;;=Z94.2^^68^676^66
 ;;^UTILITY(U,$J,358.3,10986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10986,1,3,0)
 ;;=3^Lung Transplant Status
 ;;^UTILITY(U,$J,358.3,10986,1,4,0)
 ;;=4^Z94.2
 ;;^UTILITY(U,$J,358.3,10986,2)
 ;;=^5063656
 ;;^UTILITY(U,$J,358.3,10987,0)
 ;;=Z94.3^^68^676^55
 ;;^UTILITY(U,$J,358.3,10987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10987,1,3,0)
 ;;=3^Heart & Lungs Transplant Status
 ;;^UTILITY(U,$J,358.3,10987,1,4,0)
 ;;=4^Z94.3
 ;;^UTILITY(U,$J,358.3,10987,2)
 ;;=^5063657
 ;;^UTILITY(U,$J,358.3,10988,0)
 ;;=Z94.4^^68^676^65
 ;;^UTILITY(U,$J,358.3,10988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10988,1,3,0)
 ;;=3^Liver Transplant Status
 ;;^UTILITY(U,$J,358.3,10988,1,4,0)
 ;;=4^Z94.4
 ;;^UTILITY(U,$J,358.3,10988,2)
 ;;=^5063658
 ;;^UTILITY(U,$J,358.3,10989,0)
 ;;=Z94.84^^68^676^143
