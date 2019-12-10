PSJCOM1 ;BIR/CML3 - DISPLAY COMPLEX ORDERS FOR DISCONTINUE ; 10/18/19 2:40pm
 ;;5.0;INPATIENT MEDICATIONS;**110,127,281,315,327,393**;16 DEC 97;Build 5
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ; Reference to ^VALM1 via DBIA 10116
 ; Reference to ^PS(55 via DBIA 2191
 ; Reference to ^%DTC via DBIA 10000
 ; Reference to ^PS(51.2 via DBIA 2178
 ; Reference to ^DIE via DBIA 10018
 ; Reference to ^DIR via DBIA 10026
 ; Reference to ^TMP("PSODAOC",$J) via DBIA 6071
 ;
CMPLX(PSGP,ON,PSGORD) ;
 D PAUSE K PSJCM
 N PSJLINE,PSX,PSCM
 S PSJLINE=1
 I PSGORD["P" N PSJO S PSJO=0 F  S PSJO=$O(^PS(53.1,"ACX",ON,PSJO)) Q:'PSJO  D
 .Q:PSJO=+PSGORD  S PSJOO=PSGORD D DSPLORDU(PSGP,PSJO_"P") S PSJCM(PSJO_"P",PSJLINE)="",PSJLINE=PSJLINE+1
 I PSGORD'["P" N PSJO,PSJOO S PSJOO="",PSJO=0 F  S PSJO=$O(^PS(55,"ACX",ON,PSJO)) Q:'PSJO  F  S PSJOO=$O(^PS(55,"ACX",ON,PSJO,PSJOO)) Q:PSJOO=""  D
 .Q:PSJOO=PSGORD  D:PSJOO["U" DSPLORDU(PSGP,PSJOO) D:PSJOO["V" DSPLORDV(PSGP,PSJOO) S PSJCM(PSJOO,PSJLINE)="",PSJLINE=PSJLINE+1
 N ON S ON="" F  S ON=$O(PSJCM(ON)) Q:ON=""  D
 .W ! F PSX=0:0 S PSX=$O(PSJCM(ON,PSX)) Q:'PSX  D
 ..W !,PSJCM(ON,PSX) D:'(PSX#6) PAUSE
 W !
 Q
 ;
CMPLX2(PSGP,ON,PSGORD) ;
 Q:$G(PSGORD)'["U"
 ;; START NCC REMEDIATION >> 327*RJS
 N CLOZFLG I PSGORD["U" S CLOZFLG=$$ISCLOZ^PSJCLOZ(,,PSGP,+PSGORD) I 1
 E  S CLOZFLG=$$ISCLOZ^PSJCLOZ(+PSGORD)
 I CLOZFLG D
 .N PSGDN S PSGDN=$P(CLOZFLG,U,2)
 .D PSJFILE^PSJCLOZ(PSGP),INPSND^YSCLTST5 K:$D(^TMP($J,"CLOZFLG",PSGP)) ^TMP($J,"CLOZFLG",PSGP)
 ;; END NCC REMEDIATION >> 327*RJS
 N PSJLINE S PSJLINE=0
 D FULL^VALM1
 D DSPLORDU(PSGP,PSGORD)
 W ! S PSJLINE="" F  S PSJLINE=$O(PSJCM(PSGORD,PSJLINE)) Q:PSJLINE=""  W !,PSJCM(PSGORD,PSJLINE) D:'((PSJLINE+1)#6) PAUSE
 D EN^PSGPEN(PSGORD)
 S ^TMP("PSODAOC",$J,"IP IEN")=PSJO_"P",^TMP("PSODAOC",$J,"IP NEW IEN")=PSGORD
 D SETOC^PSJNEWOC(PSGORD)
 W !
 Q
 ;
UPDATE ; Refresh array, actions, & display.
 D GETUD^PSJLMGUD(DFN,ON),INIT^PSJLMUDE(DFN,ON) S VALMBCK="R"
 Q
HOLDHDR ; Freeze header text while processing order actions
 I $D(VALM("TM")) S IOTM=VALM("TM"),IOBM=IOSL W IOSC W @IOSTBM W IORC
 Q
 ;
DSPLORDU(PSGP,ON)   ; Display UD order for order check as in the Inpat Profile.
 NEW DRUGNAME,F,NODE0,NODE2,PSJID,PSJX,SCH,SD,STAT,X,Y K PSJCM
 S F=$S(ON["U":"^PS(55,PSGP,5,"_+ON_",",1:"^PS(53.1,"_+ON_",")
 S NODE0=$G(@(F_"0)")),NODE2=$G(@(F_"2)"))
 D DRGDISP^PSJLMUT1(PSGP,ON,39,54,.DRUGNAME,0)
 I ON["P",$P(NODE0,U,4)="F" D DSPLORDV(PSGP,ON) Q
 S SCH=$P(NODE0,U,7)
 S STAT=$P(NODE0,U,9)
 D NOW^%DTC I "A"[STAT I $P(NODE2,U,4)<% D EXPIRE S STAT="E"
 I STAT="A",$P(NODE0,U,27)="R" S STAT="R"
 I STAT'="P" S PSJID=$E($$ENDTC^PSGMI($P(NODE2,U,2)),1,5),SD=$E($$ENDTC^PSGMI($P(NODE2,U,4)),1,5)
 I STAT="P" S (PSJID,SD)="*****",SCH="?"
 I $G(PSGPDN)["CLOZ" N PSGORD S PSGORD=+$G(NODE0),PSSD="" D DISPCMP^PSJCLOZ(PSGORD,.PSSD) I $G(PSSD) S SD=$E($$ENDTC^PSGMI(PSSD),1,5) K PSSD
 F PSJX=0:0 S PSJX=$O(DRUGNAME(PSJX)) Q:'PSJX  D
 . S:PSJX=1 X=SCH_"  "_PSJID_"  "_SD_"  "_$E(STAT,1)
 . S:PSJX=1 DRUGNAME(1)=$$SETSTR^VALM1(X,$E(DRUGNAME(1),1,40),42,20)
 . S PSJCM(ON,PSJLINE)="        "_DRUGNAME(PSJX)
 . S PSJLINE=PSJLINE+1
 Q
DSPLORDV(DFN,ON)   ; Display IV order for order check as in the Inpat Profile.
 N DRG,DRGI,DRGT,DRGX,FIL,ND,ON55,P,PSJIVFLG,PSJORIFN,TYP,X,Y
 S TYP="?" I ON["V" D
 .S Y=$G(^PS(55,DFN,"IV",+ON,0)) F X=2,3,4,5,8,9,17,23 S P(X)=$P(Y,U,X)
 .D NOW^%DTC I "A"[P(17) I P(3)<% D EXPIRE S P(17)="E"
 .S TYP=$$ONE^PSJBCMA(DFN,ON,P(9),P(2),P(3)) I TYP'="O" S TYP="C"
 .S ON55=ON,P("OT")=$S(P(4)="A":"F",P(4)="H":"H",1:"I") D GTDRG^PSIVORFB,GTOT^PSIVUTL(P(4))
 S PSJCT=0,PSJL=""
 I ON'["V" S (P(2),P(3))="",P(17)=$P($G(^PS(53.1,+ON,0)),U,9),Y=$G(^(8)),P(4)=$P(Y,U),P(8)=$P(Y,U,5),P(9)=$P($G(^(2)),U) D GTDRG^PSIVORFA,GTOT^PSIVUTL(P(4))
 S PSJIVFLG=1 D PIVAD,SOL
 Q
SOL ;
 S PSJL=$S($G(PSJIVFLG):PSJL,1:"")_"        in"
 S DRG=0 F  S DRG=+$O(DRG("SOL",DRG)) Q:'DRG  D NAME^PSIVUTL(DRG("SOL",DRG),39,.NAME,0) S DRGX=0 F  S DRGX=$O(NAME(DRGX)) Q:'DRGX  S PSJL=$$SETSTR^VALM1(NAME(DRGX),PSJL,12,60) D:$G(PSJIVFLG) PIV1 D SETTMP S PSJL="      "
 Q
PIVAD ; Print IV Additives.
 F DRG=0:0 S DRG=$O(DRG("AD",DRG)) Q:'DRG  D NAME^PSIVUTL(DRG("AD",DRG),39,.NAME,1) F DRGX=0:0 S DRGX=$O(NAME(DRGX)) Q:'DRGX  S PSJL=$$SETSTR^VALM1(NAME(DRGX),PSJL,9,60) D:$G(PSJIVFLG) PIV1 D SETTMP
 Q
 ;
PIV1 ; Print Sched type, start/stop dates, and status.
 K PSJIVFLG
 F X=2,3 S P(X)=$E($$ENDTC^PSGMI(P(X)),1,$S($D(PSJEXTP):8,1:5))
 I '$D(PSJEXTP) S PSJL=$$SETSTR^VALM1(TYP,PSJL,50,1),PSJL=$$SETSTR^VALM1(P(2),PSJL,53,7),PSJL=$$SETSTR^VALM1(P(3),PSJL,60,7),PSJL=$$SETSTR^VALM1(P(17),PSJL,67,1)
 E  S PSJL=$$SETSTR^VALM1(TYP,PSJL,50,1),PSJL=$$SETSTR^VALM1(P(2),53,7),PSJL=$$SETSTR^VALM1(P(3),PSJL,63,7),PSJL=$$SETSTR^VALM1(P(17),PSJL,73,1)
 Q
SETTMP ;
 S PSJCM(ON,PSJLINE)=PSJL,PSJLINE=PSJLINE+1
 Q
PAUSE ;
 K DIR W ! S DIR(0)="EA",DIR("A")="Press Return to continue..." D ^DIR W !
 Q
NEW ;
 Q:'PSJCOM
 Q:PSGORD'["P"
 M ^TMP("PSJCOM",$J,+PSGORD)=^PS(53.1,+PSGORD)
 S PSGS0Y=PSGAT,PSGNESD=PSGSD,PSGNEFD=PSGFD,PSGOEPR=PSGPR,PSGPDRG=PSGPD,PSGPDRGN=PSGPDN,PSGOEE="E"
 S $P(^TMP("PSJCOM",$J,+PSGORD,0),"^",27)="E",$P(^(0),"^",9)="DE"
 W:'$D(PSGOEE)&'$D(PSGOES) !!,"...transcribing this ",$S($D(PSGOES):"",'PSGOEAV:"non-verified ",1:"active "),"order..." S PSGOETOF=1 S:PSGSM="" PSGSM=0
 ;I PSGPR'=PSGOEPR D:'$D(^PS(55,PSGP,0)) ENSET0^PSGNE3(PSGP) S $P(^PS(55,PSGP,5.1),U,2)=PSGPR,PSGOEPR=PSGPR
 K ND4,DA D NOW^%DTC S PSGDT=+$E(%,1,12),DA=+PSGORD
 S PSJOWALL=+$G(^PS(55,PSGP,5.1))
 I $D(^PS(51.2,+PSGMR,0)),$P(^(0),U,3)]"" S PSGMRN=$P(^(0),U,3)
 I PSGS0XT="D",'PSGS0Y S PSGS0Y=$E(PSGNESD_"00011",9,12)
 S ND=DA_U_PSGPR_U_PSGMR_"^U^"_PSGSM_U_PSGHSM_U_PSGST_"^^"_$S(PSGOEAV:"A",1:"N")_"^^^^^"_PSGDT_U_PSGP_U_PSGDT S:PSGNEDFD $P(ND,U,$P(PSGNEDFD,U)["L"+10)=+PSGNEDFD
 S:$D(PSGOEE) $P(ND,U,24,25)=PSGOEE_U_PSGORD S:'PSGOEAV $P(ND,U,18)=DA S ND2=PSGSCH_U_$S(+PSGNESD=PSGNESD:+PSGNESD,1:"")_"^^"_+PSGNEFD_U_PSGS0Y_U_PSGS0XT_"^^^^"_+PSJPWD
 S:$G(PSGRF)]"" ND2P1=$G(PSGDUR)_U_$G(PSGRMVT)_U_$G(PSGRMV)_U_$G(PSGRF) ;*315
 S $P(ND4,U,7)=DUZ I PSGOEAV,PSJSYSU D
 .S $P(ND4,U,PSJSYSU,PSJSYSU+1)=DUZ_U_PSGDT,$P(ND4,U,+PSJSYSU=1+9)=1,$P(ND4,U,+PSJSYSU=3+9)=0
 .S $P(ND4,U,9,10)=+$P(ND4,U,9)_U_+$P(ND4,U,10)
 S F="^TMP(""PSJCOM2"","_$J_","_DA_",",@(F_"0)")=ND
 ; Naked references below refers to full reference in F which is ^TMP("PSJCOM2",$J,DA,
 S @(F_".2)")=PSGPDRG_U_PSGDO_U_PSJNOO S:$G(PSJDOSE("DO"))]"" $P(^(.2),U,5,6)=$P(PSJDOSE("DO"),U,1,2) S:PSJCOM]"" $P(^(.2),"^",8)=PSJCOM
 I '$D(PSJDOSE("DO")),$D(PSGORD) S $P(@(F_".2)"),U,5,6)=$P(@("^PS("_$S(PSGORD["U":"55,"_PSGP_",5",1:53.1)_","_+PSGORD_",.2)"),U,5,6)
 ; Naked references below refers to full reference in F which is ^TMP("PSJCOM2",$J,DA,
 S @(F_"2)")=$P(ND2,"^",1,6),^(4)=ND4 S:PSGSI]"" ^(6)=PSGSI
 I $G(PSGRF)]"" S @(F_"2.1)")=ND2P1 ;*315
 ; Naked references below refers to full reference in F which is ^TMP("PSJCOM2",$J,DA,
 S (C,X)=0 F  S X=$O(^PS(53.45,PSJSYSP,2,X)) Q:'X  S D=$G(^(X,0)) I D,$S('$P(D,U,3):1,1:$P(D,U,3)>DT) S C=C+1,@(F_"1,"_C_",0)")=$P(D,U,1,2),@(F_"1,""B"","_+D_","_C_")")=""
 S:C @(F_"1,0)")=U_$S(PSGOEAV:55.07,1:53.11)_"P^"_C_U_C
 ; Naked references below refers to full reference in F which is ^TMP("PSJCOM2",$J,DA,
 S (C,Q)=0 F  S Q=$O(^PS(53.45,PSJSYSP,1,Q)) Q:'Q  S X=$G(^(Q,0)) S:X]"" C=C+1,@(F_"3,"_C_",0)")=X
 S:C @(F_"3,0)")=U_$S(PSGOEAV:55.08,1:53.12)_U_C_U_C
 S:C @(F_"12,0)")=U_$S(PSGOEAV:55.0612,1:53.1012)_U_C_U_C
 W "."
OUT ;
 K PSGOETOF
DONE ;
 K C,D,ND,ND2,ND2P1,ND4,PSGDO,PSGDRG,PSGDRGN,PSGFOK,PSGHSM,PSGMR,PSGMRN,PSGNEDFD,PSGNEFD,PSGNESD,PSGPDRG,PSGPDRGN,PSGSI,PSGSTN,PSJDOSE,%,Q
 Q
EXPIRE ;Change status of order to expired and send notice to OE/RR
 N DA,DIE,DR,PSGPO,PSIVACT
 Q:'$G(PSJOO)!($G(PSJOO)["P")
 S STATUS="E",(PSGPO,PSIVACT)=1,DA=+PSJOO,DA(1)=PSGP,DIE=$S(PSJOO["V":"^PS(55,"_PSGP_",""IV"",",1:"^PS(55,"_PSGP_",5,"),DR=$S(PSJOO["V":"100////E",1:"28////E") D ^DIE
 D EN1^PSJHL2(PSGP,"SC",PSJOO)
 Q
