IBDEI0FX ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7708,2)
 ;;=^99481
 ;;^UTILITY(U,$J,358.3,7709,0)
 ;;=791.0^^55^587^57
 ;;^UTILITY(U,$J,358.3,7709,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7709,1,4,0)
 ;;=4^791.0
 ;;^UTILITY(U,$J,358.3,7709,1,5,0)
 ;;=5^Proteinuria
 ;;^UTILITY(U,$J,358.3,7709,2)
 ;;=^99873
 ;;^UTILITY(U,$J,358.3,7710,0)
 ;;=790.93^^55^587^52
 ;;^UTILITY(U,$J,358.3,7710,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7710,1,4,0)
 ;;=4^790.93
 ;;^UTILITY(U,$J,358.3,7710,1,5,0)
 ;;=5^PSA,Elevated
 ;;^UTILITY(U,$J,358.3,7710,2)
 ;;=^334262
 ;;^UTILITY(U,$J,358.3,7711,0)
 ;;=309.81^^55^587^53
 ;;^UTILITY(U,$J,358.3,7711,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7711,1,4,0)
 ;;=4^309.81
 ;;^UTILITY(U,$J,358.3,7711,1,5,0)
 ;;=5^PTSD
 ;;^UTILITY(U,$J,358.3,7711,2)
 ;;=^114692
 ;;^UTILITY(U,$J,358.3,7712,0)
 ;;=473.8^^55^587^58
 ;;^UTILITY(U,$J,358.3,7712,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7712,1,4,0)
 ;;=4^473.8
 ;;^UTILITY(U,$J,358.3,7712,1,5,0)
 ;;=5^Sinusitis,Chronic
 ;;^UTILITY(U,$J,358.3,7712,2)
 ;;=^269890
 ;;^UTILITY(U,$J,358.3,7713,0)
 ;;=780.57^^55^587^60
 ;;^UTILITY(U,$J,358.3,7713,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7713,1,4,0)
 ;;=4^780.57
 ;;^UTILITY(U,$J,358.3,7713,1,5,0)
 ;;=5^Sleep Apnea
 ;;^UTILITY(U,$J,358.3,7713,2)
 ;;=^332928
 ;;^UTILITY(U,$J,358.3,7714,0)
 ;;=722.10^^55^587^61
 ;;^UTILITY(U,$J,358.3,7714,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7714,1,4,0)
 ;;=4^722.10
 ;;^UTILITY(U,$J,358.3,7714,1,5,0)
 ;;=5^Spine HNP
 ;;^UTILITY(U,$J,358.3,7714,2)
 ;;=^272469
 ;;^UTILITY(U,$J,358.3,7715,0)
 ;;=436.^^55^587^62
 ;;^UTILITY(U,$J,358.3,7715,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7715,1,4,0)
 ;;=4^436.
 ;;^UTILITY(U,$J,358.3,7715,1,5,0)
 ;;=5^Stroke
 ;;^UTILITY(U,$J,358.3,7715,2)
 ;;=^2710
 ;;^UTILITY(U,$J,358.3,7716,0)
 ;;=305.90^^55^587^63
 ;;^UTILITY(U,$J,358.3,7716,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7716,1,4,0)
 ;;=4^305.90
 ;;^UTILITY(U,$J,358.3,7716,1,5,0)
 ;;=5^Substance Abuse,Unspec
 ;;^UTILITY(U,$J,358.3,7716,2)
 ;;=^268258
 ;;^UTILITY(U,$J,358.3,7717,0)
 ;;=388.30^^55^587^64
 ;;^UTILITY(U,$J,358.3,7717,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7717,1,4,0)
 ;;=4^388.30
 ;;^UTILITY(U,$J,358.3,7717,1,5,0)
 ;;=5^Tinnitus
 ;;^UTILITY(U,$J,358.3,7717,2)
 ;;=^119771
 ;;^UTILITY(U,$J,358.3,7718,0)
 ;;=305.1^^55^587^65
 ;;^UTILITY(U,$J,358.3,7718,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7718,1,4,0)
 ;;=4^305.1
 ;;^UTILITY(U,$J,358.3,7718,1,5,0)
 ;;=5^Tobacco Abuse
 ;;^UTILITY(U,$J,358.3,7718,2)
 ;;=^119899
 ;;^UTILITY(U,$J,358.3,7719,0)
 ;;=465.9^^55^587^66
 ;;^UTILITY(U,$J,358.3,7719,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7719,1,4,0)
 ;;=4^465.9
 ;;^UTILITY(U,$J,358.3,7719,1,5,0)
 ;;=5^Upper Respiratory Tract Infection
 ;;^UTILITY(U,$J,358.3,7719,2)
 ;;=^269878
 ;;^UTILITY(U,$J,358.3,7720,0)
 ;;=703.8^^55^587^27
 ;;^UTILITY(U,$J,358.3,7720,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7720,1,4,0)
 ;;=4^703.8
 ;;^UTILITY(U,$J,358.3,7720,1,5,0)
 ;;=5^Dystrophic Nails
 ;;^UTILITY(U,$J,358.3,7720,2)
 ;;=^271926
 ;;^UTILITY(U,$J,358.3,7721,0)
 ;;=780.52^^55^587^39
 ;;^UTILITY(U,$J,358.3,7721,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7721,1,4,0)
 ;;=4^780.52
 ;;^UTILITY(U,$J,358.3,7721,1,5,0)
 ;;=5^Insomnia
 ;;^UTILITY(U,$J,358.3,7721,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,7722,0)
 ;;=600.01^^55^587^14
 ;;^UTILITY(U,$J,358.3,7722,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7722,1,4,0)
 ;;=4^600.01
 ;;^UTILITY(U,$J,358.3,7722,1,5,0)
 ;;=5^BPH with Obstruction
 ;;^UTILITY(U,$J,358.3,7722,2)
 ;;=^334256
 ;;^UTILITY(U,$J,358.3,7723,0)
 ;;=346.90^^55^587^43