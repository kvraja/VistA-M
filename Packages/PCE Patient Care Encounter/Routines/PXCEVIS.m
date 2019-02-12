PXCEVIS ;BHM/ADM - Used to edit and display VIS ;06/29/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**210,211**;Aug 12, 1996;Build 325
 ;;
 Q
EVIS ; add/edit VIS OFFERED/GIVEN TO PATIENT
 Q:'(+$G(PXCEFIEN)!+$G(PXVNEWDA))
 N DA,DIE,DR
 S DA=$S(+$G(PXCEFIEN):PXCEFIEN,1:PXVNEWDA)
 S DIE="^AUPNVIMM(",DR="2" D ^DIE
 Q
 ;
DISPVIS(PXCEINT,PXCEDT) ; display VIS name with EDITION DATE
 N PXCEDILF,PXCEEXT,PXV2,PXV3,PXVED,PXVDT
 S PXCEEXT=$$EXTERNAL^DILFD(9000010.112,.01,"",PXCEINT,"PXCEDILF")
 I PXCEINT D
 .S PXV2=$P($G(^AUTTIVIS(PXCEINT,0)),"^",2),PXVED=$$EXTERNAL^DILFD(920,.02,"",PXV2,"PXCEDILF")
 .S PXV3=$P($G(^AUPNVIMM(IEN,2,CNT,0)),"^",2),PXVDT=$$EXTERNAL^DILFD(9000010.112,.02,"",PXV3,"PXCEDILF")
 I $L(PXCEEXT) S PXCEEXT=PXCEEXT_" (Ed. "_PXVED_")"
 I $G(PXV3) S PXCEEXT=PXCEEXT_"  Offered/Given: "_PXVDT
 Q $S('$D(DIERR):PXCEEXT,1:PXCEINT)
 ;
