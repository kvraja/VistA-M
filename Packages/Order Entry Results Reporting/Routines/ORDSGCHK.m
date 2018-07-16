ORDSGCHK ;SLC/AGP - PRE 0.5 DOSE ORDER CHECKS;03/29/18  05:57
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**280,352,345,311,384,395,382,481**;Dec 17, 1997;Build 3
 ;
EN(ORY,DFN,TYPE,OIL) ;
 N ARRAY,CNT,NAME
 ;if renewed order build OIL array
 I $G(ORREN)=1,+$G(ORIFN)>0 D
 .;IV orders should only have a null type
 .I TYPE="" S TYPE="PSIV"
 .D BLDREN(TYPE,ORIFN,.OIL)
 ;Build easy array to work with
 S CNT=0 F  S CNT=$O(OIL(CNT)) Q:CNT'>0  D
 .S NODE=$G(OIL(CNT)) Q:$P(NODE,U,2)="PSIV"
 .S NAME=$P(NODE,U,2)
 .Q:'$P(NODE,U,3)
 .S ARRAY(NAME,$P(NODE,U,3))=NODE
 I TYPE="PSH" Q
 I TYPE="PSIV" D IV(.ORY,DFN,.ARRAY)
 I TYPE'="PSIV" D NONIV(.ORY,DFN,.ARRAY)
 Q
 ;
BLDREN(TYPE,ORIFN,OUT) ;
 N CNT,EXTVALUE,ISOI,ITEM,LOC,NAME,NUM,NODE,ORDIALOG,TEXT,VALUE,X0,ORDSGSET
 S ORDSGSET=0
 S CNT=$O(OUT(""),-1)
 S X0=$G(^OR(100,+ORIFN,0))
 S ORDIALOG=+$P(X0,U,5)
 D GETDLG^ORCD(ORDIALOG)
 D GETORDER^ORCD(+ORIFN)
 S LOC=0 F  S LOC=$O(ORDIALOG(LOC)) Q:LOC'>0  D
 .S ITEM=$P($G(ORDIALOG(LOC)),U,2)
 .I ITEM="" Q
 .I ITEM="COMMENT" Q
 .S ISOI=$S($G(ORDIALOG(LOC,0))[101.43:1,1:0)
 .S NUM=0 F  S NUM=$O(ORDIALOG(LOC,NUM)) Q:NUM'>0  D
 ..I NUM<1 Q
 ..S VALUE=$G(ORDIALOG(LOC,NUM)),EXTVALUE=""
 ..I ISOI=1 D
 ...S EXTVALUE=$P($G(^ORD(101.43,VALUE,0)),U)
 ...I $P($G(^ORD(101.41,LOC,0)),U)="OR GTX ADDITIVE" S ITEM="ADDITIVE"
 ..I ITEM="RATE" S EXTVALUE=VALUE
 ..I ITEM="DOSE" S ORDSGSET=1
 ..S TEXT=TYPE_U_ITEM_U_NUM_U_VALUE_U_EXTVALUE
 ..S CNT=CNT+1,OUT(CNT)=TEXT
 ;SET THE DOSE AS BLANK IN THE OUTPUT ARRAY IF IT WASN'T SET ALREADY
 I 'ORDSGSET S CNT=CNT+1,OUT(CNT)=TYPE_U_"DOSE^1^^"
 Q
 ;
DURATION(STR) ;
 N LEN,VAL,UNIT,IVLMT,TVAL
 S (UNIT,IVLMT)="",VAL=0
 I $E($$LOW^XLFSTR(STR))="f" D
 . I STR["for a total of" D  Q
 . .S VAL=$P(STR," ",5)
 . .S UNIT=$P(STR," ",6)
 . .S STR=""
 . S VAL=$P(STR," ",2)
 . S UNIT=$E($P(STR," ",3))
 . S STR=""
 I $E($$LOW^XLFSTR(STR))="w" D
 . S TVAL=$P(STR," ",4)
 . S VAL=+TVAL
 . S LEN=$F(TVAL,VAL)
 . I $P(VAL,".")="" S VAL=0_VAL
 . F  S UNIT=$E(TVAL,LEN) Q:((UNIT'=0)&(UNIT'="."))  D
 . . S LEN=LEN+1
 . S STR=""
 I $L(UNIT),$L(VAL) S IVLMT=VAL_$$UP^XLFSTR(UNIT)
 I STR'="",IVLMT="" D
 .I STR["ML" S IVLMT=$P(STR,"M")_"M" Q
 .I STR["CC" S IVLMT=$P(STR,"C")_"M" Q
 .S IVLMT=STR
 Q IVLMT
 ;
IV(ORY,DFN,ARRAY) ;
 N CNT,DRUG,DRUGIEN,DRUGNAME,NAME,NUM,OI,ORBASE,ORPSJARR,STR,STRENGTH,NODE
 ;
 I '$D(ARRAY) D  Q
 . S ORY=$G(ORY)+1,ORY(ORY)="ERR^Incomplete data.  Dosage check could not be performed."
 ;populate single values from order
 S ORPSJARR("TVOL_DUR")="",ORPSJARR("SCHEDULE")=""
 I $D(ARRAY("DAYS")) S ORPSJARR("TVOL_DUR")=$$DURATION($P(ARRAY("DAYS",1),U,4))
 ;S RATE=$P(ARRAY(NAME,1),U,4)
 S ORPSJARR("MR_IEN")=$P(ARRAY("ROUTE",1),U,4)
 I $D(ARRAY("SCHEDULE")) S ORPSJARR("SCHEDULE")=$P(ARRAY("SCHEDULE",1),U,4)
 S ORPSJARR("IV_TYPE")=$S($P(ARRAY("TYPE",1),U,4)="I":1,1:2)
 I ORPSJARR("IV_TYPE")=2 S ORPSJARR("INF_RATE")=$P(ARRAY("RATE",1),U,5)
 ;
 ;build additive first, Drug, Strength/unit, bag
 F NAME="ADDITIVE","ORDERABLE" D
 .K DRUG
 .S CNT=0,NUM=0
 .F  S NUM=$O(ARRAY(NAME,NUM)) Q:NUM'>0  D
 ..S CNT=CNT+1
 ..S NODE=$G(ARRAY(NAME,NUM)),OI=$P(NODE,U,4)
 ..;
 ..S DRUGIEN=+$P(^ORD(101.43,OI,0),U,2) I DRUGIEN="" Q  ;PHARMACY OI FROM 101.43
 ..S DRUGNAME=$P($G(ARRAY(NAME,NUM)),U,5) ;OI NAME
 ..;
 ..I NAME="ADDITIVE" D  Q
 ...S STRENGTH=$P($G(ARRAY("STRENGTH",NUM)),U,4)_" "_$P($G(ARRAY("UNITS",NUM)),U,4)
 ...S STR=+DRUGIEN_U_DRUGNAME_U_STRENGTH_U_$P($G(ARRAY("ADDFREQ",NUM)),U,4)
 ...S ORPSJARR("AD",CNT)=STR_U_0
 ...;check if enhanced order checks were done for this drug order and if so set ORDRUG(CNT,"ENH")=1
 ...I $G(^TMP($J,"ORENHCHK"))=1 S ORPSJARR("AD",CNT)=STR_U_1
 ..;
 ..;Solution information
 ..S STR=+DRUGIEN_U_DRUGNAME_U_$P($G(ARRAY("VOLUME",NUM)),U,4)_" ML"
 ..S ORPSJARR("SOL",CNT)=STR,$P(ORPSJARR("SOL",CNT),U,5)=0
 ..;check if enhanced order checks were done for this drug order and if so set ORDRUG(CNT,"ENH")=1
 ..I $G(^TMP($J,"ORENHCHK"))=1 S ORPSJARR("SOL",CNT)=STR,$P(ORPSJARR("SOL",CNT),U,5)=1
 ;
 I $D(^TMP($J,"ORDSGCHK_CACHE")) M ^TMP($J,"ORDSGCHK2")=^TMP($J,"ORDSGCHK_CACHE")
 I '$D(^TMP($J,"ORDSGCHK_CACHE")) D
 .S ORBASE(1)="ORDSGCHK1"
 .S ORBASE(2)="ORDSGCHK2"
 .D DOSE^PSJAPIDS(.ORBASE,DFN,.ORPSJARR)
 .M ^TMP($J,"ORDSGCHK_CACHE")=^TMP($J,"ORDSGCHK2")
 D PARSEOUT
 K ^TMP($J,"ORDSGCHK1"),^TMP($J,"ORDSGCHK2")
 Q
 ;
NONIV(ORY,DFN,ARRAY) ;
 N CNT,DOSESTR,DRUG,DRUGARR,DRUGIEN,DRUGNAME,DUR,NAME,NODE
 N OIIEN,ORBASE,ORDRUG,ORPSARR,PACK,PSNODE,SUB,TYPE,ADMIN
 ;
 ;assume same drug type used throughout the order dialog
 ;new free-text dose orders do not have a drug, all other free-text orders do
 S DRUGIEN=+$P($G(ARRAY("DRUG",1)),U,4)
 I DRUGIEN>0,$$EXMT^PSSDSAPI(DRUGIEN)=1 Q
 ;if no ARRAY(DOSE) node set it to null to force free text evaluation
 N I S I=0 F  S I=$O(ARRAY("INSTR",I)) Q:'I  I '$D(ARRAY("DOSE",I))  S ARRAY("DOSE",I)=$P(ARRAY("INSTR",I),U)_"^DOSE^"_I_"^"
 ;
 S ADMIN="",ADMIN("SAVE")=1
 S NAME="" F  S NAME=$O(ARRAY(NAME)) Q:NAME=""  D
 .S SUB=$$GETSUB(NAME) I SUB="" Q
 .S CNT=0 F  S CNT=$O(ARRAY(NAME,CNT)) Q:CNT'>0  D
 ..S NODE=$G(ARRAY(NAME,CNT))
 ..;
 ..;get dose information and drug information from Dose Prompt
 ..I SUB="DOSE" D
 ...S PACK=$P(NODE,U)
 ...S TYPE=$S($P(NODE,U)="PSO":"O",1:"I")
 ...S DOSESTR=$P(NODE,U,4)
 ...;free text dose
 ...I DOSESTR="" D
 ....S ORDRUG(CNT,"RX_NUM")=TYPE_";1;PROSPECTIVE;"_CNT
 ....;I DRUGIEN>0 D  Q
 ....;.S ORPSARR(CNT,"DO")=$P($G(ARRAY("INSTR",CNT)),U,4)
 ....;.S ORDRUG(CNT,"DRUG_IEN")=DRUGIEN
 ....;.S ORDRUG(CNT,"DRUG_NM")=$$GETPSNM^ORKPS(DRUGIEN) ;DRUGNAME
 ....N ORTDOSE,ORTDNAME
 ....S ARRAY("ORPSA",CNT)=$$OI2DD^ORKPS($P(ARRAY("ORDERABLE",1),U,4),$E($P(ARRAY("ORDERABLE",1),U,1),3),2)
 ....Q:'$P(ARRAY("ORPSA",CNT),";",1)
 ....K ^TMP($J,"DRUGARR") D ZERO^PSS50($P(ARRAY("ORPSA",CNT),";",1),,,,,"DRUGARR")
 ....N ORDRGNM S ORDRGNM=$G(^TMP($J,"DRUGARR",$P(ARRAY("ORPSA",CNT),";",1),.01))
 ....S ORPSARR(CNT,"DO")=$$TRIM^ORBCMA32($P($P($G(ARRAY("INSTR",CNT)),U,4),ORDRGNM))
 ....S OIIEN=$P($G(ARRAY("ORDERABLE",1)),U,4) ;orderable only exists for first item (in complex order)
 ....S ORDRUG("OI")=+$P($G(^ORD(101.43,OIIEN,0)),U,2)
 ....S ORDRUG("PACKAGE")=$S(PACK="PSO":"O",PACK="PSH":"X",1:"I")
 ....S PSNODE=$G(^ORD(101.43,OIIEN,"PS"))
 ....S ORDRUG("OI_USAGE")=$S($P(PSNODE,U,4)=1:"A",1:"")_$S($P(PSNODE,U,3)=1:"B",1:"")
 ....S ORDRUG(CNT,"DRUG_NM")=$$TRIM^ORBCMA32($P($G(ARRAY("ORDERABLE",1)),U,5))
 ...;
 ...;check if enhanced order checks were done for this drug order and if so set ORDRUG(CNT,"ENH")=1
 ...I $G(^TMP($J,"ORENHCHK"))=1,((DOSESTR=""&$D(ORDRUG))!(DOSESTR'="")) S ORDRUG(CNT,"ENH")=1
 ...Q:DOSESTR=""
 ...S DRUGIEN=$P(DOSESTR,"&",6)
 ...K ^TMP($J,"DRUGARR")
 ...D ZERO^PSS50(DRUGIEN,,,,,"DRUGARR")
 ...S DRUGNAME=$G(^TMP($J,"DRUGARR",DRUGIEN,.01))
 ...K ^TMP($J,"DRUGARR")
 ...;
 ...;Local Possible Dose
 ...I $P(DOSESTR,"&")="" D  Q
 ....S ORPSARR(CNT,"DO")=$P($G(ARRAY("INSTR",CNT)),U,4)
 ....S ORDRUG(CNT,"RX_NUM")=TYPE_";1;PROSPECTIVE;"_CNT
 ....S ORDRUG(CNT,"DRUG_IEN")=DRUGIEN
 ....S ORDRUG(CNT,"DRUG_NM")=$$GETPSNM^ORKPS(DRUGIEN) ;DRUGNAME
 ...;
 ...;Possible Dose
 ...S ORPSARR(CNT,"DRG_AMT")=$P(DOSESTR,"&")
 ...S ORPSARR(CNT,"DRG_UNIT")=$P(DOSESTR,"&",2)
 ...S ORDRUG(CNT,"RX_NUM")=TYPE_";1;PROSPECTIVE;"_CNT
 ...S ORDRUG(CNT,"DRUG_IEN")=DRUGIEN
 ...S ORDRUG(CNT,"DRUG_NM")=$$GETPSNM^ORKPS(DRUGIEN) ;DRUGNAME
 ..;
 ..;Additional Order Data
 ..I SUB="DRATE" D  Q
 ...S DUR=$P($P(NODE,U,4)," ")
 ...S ORPSARR(CNT,SUB)=DUR_$$DRATESTR($P($P(NODE,U,4)," ",2))
 ..I SUB="CONJ",$P(NODE,U)="PSI",ADMIN("SAVE") D
 ...S:$D(ARRAY("SCHEDULE",CNT))=1 ADMIN=ADMIN_";"_$P(ARRAY("SCHEDULE",CNT),U,4)
 ...I $P($G(ARRAY(SUB,CNT)),U,4)'="A" S ADMIN("SAVE")=0
 ..S ORPSARR(CNT,SUB)=$P(NODE,U,4)
 ;
 ;Get rid of any preceeding or trailing spaces on the dose
 N ORSPI S ORSPI=0 F  S ORSPI=$O(ORPSARR(ORSPI)) Q:'ORSPI  D
 .I $D(ORPSARR(ORSPI,"DO")) S ORPSARR(ORSPI,"DO")=$$TRIM^XLFSTR(ORPSARR(ORSPI,"DO"))
 ;
 I ADMIN'="" D
 .N ORAT
 .D ADMIN^ORWDPS2(.ORAT,DFN,ADMIN,$P($G(ARRAY("ORDERABLE",1)),U,4),+ORL,$P($G(ARRAY("ADMIN",1)),U,4))
 .I $P(ORAT,U,4)'="" S ORPSARR(1,"EFD")=$P(ORAT,U,4)
 ;
 I $D(ORDRUG) D
 .S ORBASE(1)="ORDSGCHK1",ORBASE(2)="ORDSGCHK2"
 .S ORPSARR("CONTEXT")="CPRS-UD"
 .D DOSE^PSSDSAPD(.ORBASE,DFN,.ORPSARR,.ORDRUG),PARSEOUT
 .K ^TMP($J,"ORDSGCHK1"),^TMP($J,"ORDSGCHK2")
 Q
 ;
PARSEOUT ;PARSE OUTPUT GLOBAL
 N ORNBP S ORNBP=""
 I $D(^TMP($J,"ORDSGCHK2")) D
 .I $P($G(^TMP($J,"ORDSGCHK2","OUT",0)),U)=-1 S ORNBP=$$DSDWNMSG^ORDSGCHK Q
 .I $D(^TMP($J,"ORDSGCHK2","OUT","ERROR")) D
 ..N I S I="" F  S I=$O(^TMP($J,"ORDSGCHK2","OUT","ERROR",I)) Q:'$L(I)  D
 ...N J S J="" F  S J=$O(^TMP($J,"ORDSGCHK2","OUT","ERROR",I,J)) Q:'$L(J)  D
 ....N K S K="" F  S K=$O(^TMP($J,"ORDSGCHK2","OUT","ERROR",I,J,K)) Q:'$L(K)  D
 .....I $L($G(^TMP($J,"ORDSGCHK2","OUT","ERROR",I,J,K,"MSG"))) S ORY=$G(ORY)+1,ORY(ORY)="ERR^"_^TMP($J,"ORDSGCHK2","OUT","ERROR",I,J,K,"MSG") D
 ......I $L($G(^TMP($J,"ORDSGCHK2","OUT","ERROR",I,J,K,"TEXT"))) S ORY(ORY)=ORY(ORY)_"  "_$G(^TMP($J,"ORDSGCHK2","OUT","ERROR",I,J,K,"TEXT"))
 .I $D(^TMP($J,"ORDSGCHK2","OUT","CHECK")) D
 .N ORI S ORI=0 F  S ORI=$O(^TMP($J,"ORDSGCHK2","OUT","CHECK",ORI)) Q:'ORI  D
 ..N ORJ S ORJ="" F  S ORJ=$O(^TMP($J,"ORDSGCHK2","OUT","CHECK",ORI,ORJ)) Q:'$L(ORJ)  D
 ...N ORK S ORK=0 F  S ORK=$O(^TMP($J,"ORDSGCHK2","OUT","CHECK",ORI,ORJ,ORK)) Q:'ORK  D
 ....N ORDGTYPE S ORDGTYPE="DS"
 ....N ORRTTYPE S ORRTTYPE=$P($G(^TMP($J,"ORDSGCHK2","OUT","CHECK",ORI,ORJ,ORK,"ATYPE")),U,2)
 ....I ORRTTYPE="INFORMATIONAL" S ORDGTYPE="INFO"
 ....I ORRTTYPE="GENERAL" S ORDGTYPE="INFO"
 ....I ORRTTYPE="EXCEPTION" S ORDGTYPE="INFO"
 ....S ORY=$G(ORY)+1,ORY(ORY)=ORDGTYPE_U
 ....N ORL S ORL=0 F  S ORL=$O(^TMP($J,"ORDSGCHK2","OUT","CHECK",ORI,ORJ,ORK,"MSG",ORL)) Q:'ORL  D
 .....S ORY(ORY)=ORY(ORY)_^TMP($J,"ORDSGCHK2","OUT","CHECK",ORI,ORJ,ORK,"MSG",ORL)_" "
 I $L(ORNBP)>1 S ORY=$G(ORY)+1,ORY(ORY)="ERR^"_ORNBP,ORNBP=""
 Q
 ;
GETSUB(NAME) ;
 I NAME="DAYS" Q "DRATE"
 I NAME="ROUTE" Q "MR_IEN"
 I "^CONJ^DOSE^SCHEDULE^"[(U_NAME_U) Q NAME
 Q ""
 ;
DRATESTR(ORIN) ;change the form of the DURATION
 ;DAYS=D,WEEKS=W,MONTHS=L,HOURS=H,MINUTES=M
 I $$UP^XLFSTR(ORIN)="MONTHS" Q "L"
 Q $E($$UP^XLFSTR(ORIN))
 ;
DSDWNMSG() ;dosage down message (not displayed to user)
 Q "Drug Dosage checks were not able to be performed."
