IBDEI19E ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,22548,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22548,1,4,0)
 ;;=4^V79.3
 ;;^UTILITY(U,$J,358.3,22548,1,5,0)
 ;;=5^SCREEN-DEVELOPMENT PROB
 ;;^UTILITY(U,$J,358.3,22548,2)
 ;;=^295680
 ;;^UTILITY(U,$J,358.3,22549,0)
 ;;=V79.8^^141^1378^2
 ;;^UTILITY(U,$J,358.3,22549,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22549,1,4,0)
 ;;=4^V79.8
 ;;^UTILITY(U,$J,358.3,22549,1,5,0)
 ;;=5^SCREEN-MENTAL DIS NEC
 ;;^UTILITY(U,$J,358.3,22549,2)
 ;;=^295681
 ;;^UTILITY(U,$J,358.3,22550,0)
 ;;=V65.0^^141^1379^4
 ;;^UTILITY(U,$J,358.3,22550,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22550,1,4,0)
 ;;=4^V65.0
 ;;^UTILITY(U,$J,358.3,22550,1,5,0)
 ;;=5^HEALTHY PERSON W SICK
 ;;^UTILITY(U,$J,358.3,22550,2)
 ;;=^295561
 ;;^UTILITY(U,$J,358.3,22551,0)
 ;;=V65.19^^141^1379^9
 ;;^UTILITY(U,$J,358.3,22551,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22551,1,4,0)
 ;;=4^V65.19
 ;;^UTILITY(U,$J,358.3,22551,1,5,0)
 ;;=5^PERSON CONSULT FOR ANOTH
 ;;^UTILITY(U,$J,358.3,22551,2)
 ;;=^329985
 ;;^UTILITY(U,$J,358.3,22552,0)
 ;;=V65.2^^141^1379^10
 ;;^UTILITY(U,$J,358.3,22552,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22552,1,4,0)
 ;;=4^V65.2
 ;;^UTILITY(U,$J,358.3,22552,1,5,0)
 ;;=5^PERSON FEIGNING ILLNESS
 ;;^UTILITY(U,$J,358.3,22552,2)
 ;;=^92393
 ;;^UTILITY(U,$J,358.3,22553,0)
 ;;=V65.40^^141^1379^6
 ;;^UTILITY(U,$J,358.3,22553,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22553,1,4,0)
 ;;=4^V65.40
 ;;^UTILITY(U,$J,358.3,22553,1,5,0)
 ;;=5^OTH UNSP COUNSEL
 ;;^UTILITY(U,$J,358.3,22553,2)
 ;;=^87449
 ;;^UTILITY(U,$J,358.3,22554,0)
 ;;=V65.42^^141^1379^3
 ;;^UTILITY(U,$J,358.3,22554,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22554,1,4,0)
 ;;=4^V65.42
 ;;^UTILITY(U,$J,358.3,22554,1,5,0)
 ;;=5^COUNSEL-SUBS USE/ABUSE
 ;;^UTILITY(U,$J,358.3,22554,2)
 ;;=^303467
 ;;^UTILITY(U,$J,358.3,22555,0)
 ;;=V65.43^^141^1379^1
 ;;^UTILITY(U,$J,358.3,22555,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22555,1,4,0)
 ;;=4^V65.43
 ;;^UTILITY(U,$J,358.3,22555,1,5,0)
 ;;=5^COUNSEL-INJURY PREVEN
 ;;^UTILITY(U,$J,358.3,22555,2)
 ;;=^303468
 ;;^UTILITY(U,$J,358.3,22556,0)
 ;;=V65.44^^141^1379^5
 ;;^UTILITY(U,$J,358.3,22556,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22556,1,4,0)
 ;;=4^V65.44
 ;;^UTILITY(U,$J,358.3,22556,1,5,0)
 ;;=5^HIV COUNSELING
 ;;^UTILITY(U,$J,358.3,22556,2)
 ;;=^303469
 ;;^UTILITY(U,$J,358.3,22557,0)
 ;;=V65.45^^141^1379^2
 ;;^UTILITY(U,$J,358.3,22557,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22557,1,4,0)
 ;;=4^V65.45
 ;;^UTILITY(U,$J,358.3,22557,1,5,0)
 ;;=5^COUNSEL-OTH SEX TX DISEASES
 ;;^UTILITY(U,$J,358.3,22557,2)
 ;;=^303470
 ;;^UTILITY(U,$J,358.3,22558,0)
 ;;=V65.49^^141^1379^7
 ;;^UTILITY(U,$J,358.3,22558,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22558,1,4,0)
 ;;=4^V65.49
 ;;^UTILITY(U,$J,358.3,22558,1,5,0)
 ;;=5^OTHER SPECIFIED COUNSELING
 ;;^UTILITY(U,$J,358.3,22558,2)
 ;;=^303471
 ;;^UTILITY(U,$J,358.3,22559,0)
 ;;=V65.5^^141^1379^8
 ;;^UTILITY(U,$J,358.3,22559,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22559,1,4,0)
 ;;=4^V65.5
 ;;^UTILITY(U,$J,358.3,22559,1,5,0)
 ;;=5^PERSN W FEARED COMPLAINT
 ;;^UTILITY(U,$J,358.3,22559,2)
 ;;=^295564
 ;;^UTILITY(U,$J,358.3,22560,0)
 ;;=V65.8^^141^1379^11
 ;;^UTILITY(U,$J,358.3,22560,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22560,1,4,0)
 ;;=4^V65.8
 ;;^UTILITY(U,$J,358.3,22560,1,5,0)
 ;;=5^REASON FOR CONSULT NEC
 ;;^UTILITY(U,$J,358.3,22560,2)
 ;;=^295565
 ;;^UTILITY(U,$J,358.3,22561,0)
 ;;=V40.0^^141^1380^4
 ;;^UTILITY(U,$J,358.3,22561,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,22561,1,4,0)
 ;;=4^V40.0
 ;;^UTILITY(U,$J,358.3,22561,1,5,0)
 ;;=5^PROBLEMS WITH LEARNING