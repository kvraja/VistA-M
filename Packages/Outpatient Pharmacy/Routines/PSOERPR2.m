PSOERPR2 ;BIRM/MFR - eRx Holding Queue Preferences - Single Patient Queue ;08/29/22
 ;;7.0;OUTPATIENT PHARMACY;**700,746**;DEC 1997;Build 106
 ;
EN ; - Entry Point
 N DIR,DIRUT,DIROUT,PSOPRIEN,DA,X,Y
 S PSOPRIEN=+$O(^PS(52.35,"B","ERX HOLDING QUEUE PREFERENCES",0)) I 'PSOPRIEN Q
 ;
 S (PSOCHNG,PSOQUIT)=0 D FULL^VALM1 W !
 ;
 ; - Reset user/division preferences
 I $D(^PS(52.35,PSOPRIEN,"SPV",DUZ)) D
 . D DISPLAY
 . S DIR("A")="     Delete this saved default view? "
 . S DIR(0)="YA",DIR("B")="NO" D ^DIR I $D(DIRUT)!$D(DIROUT) S PSOQUIT=1 Q
 . I Y=1 D DELETE,LOAD
 . W !
 I PSOQUIT Q
 ;
LKBKD ; - Look Back Days
 K DIR,DIRUT,DIROUT,SAVEX,X,Y
 S DIR(0)="52.352,1",DIR("B")=PSOLKBKD
 D ^DIR I $D(DIRUT)!$D(DIROUT) G @$$GOTO(X,"LKBKD")
 W $S(X>0:" DAYS",1:" (TODAY'S)") S PSOLKBKD=X
 D CHANGED("LKBKD",PSOLKBKD)
 ;
SRTBY ; - Sort By 
 K DIR,DIRUT,DIROUT,X,Y
 S DIR(0)="52.352,2",DIR("B")=PSOSRTBY
 D ^DIR I $D(DIRUT)!$D(DIROUT) G @$$GOTO(X,"SRTBY")
 S PSOSRTBY=Y D CHANGED("SRTBY",PSOSRTBY)
 ;
ORDER ; - Sort Order 
 K DIR,DIRUT,DIROUT,X,Y
 S DIR(0)="52.352,3",DIR("B")=PSORDER
 D ^DIR I $D(DIRUT)!$D(DIROUT) G @$$GOTO(X,"ORDER")
 S PSORDER=Y D CHANGED("ORDER",PSORDER)
 ;
DETDP ; - Display Details
 K DIR,DIRUT,DIROUT,X,Y
 S DIR(0)="52.352,4",DIR("B")=$S(PSODETDP:"YES",1:"NO")
 D ^DIR I $D(DIRUT)!$D(DIROUT) G @$$GOTO(X,"DETDP")
 S PSODETDP=Y D CHANGED("DETDP",PSODETDP)
 ;
GRPCS ; - Group By CS/Non-CS 
 K DIR,DIRUT,DIROUT,X,Y
 S DIR(0)="52.352,5",DIR("B")=$S(PSOCSGRP:"YES",1:"NO")
 D ^DIR I $D(DIRUT)!$D(DIROUT) G @$$GOTO(X,"GRPCS")
 S PSOCSGRP=Y D CHANGED("GRPCS",PSOCSGRP)
 ;
ALLST ; - Display All Statuses
 K DIR,DIRUT,DIROUT,X,Y
 S DIR(0)="52.352,6",DIR("B")=$S(PSOALLST:"YES",1:"NO")
 D ^DIR I $D(DIRUT)!$D(DIROUT) G @$$GOTO(X,"ALLST")
 S PSOALLST=Y D CHANGED("ALLST",PSOALLST)
 ;
EXIT ; Exit
 ; - Save view?
 I $G(PSOCHNG) D
 . W ! S DIR(0)="YA",DIR("B")="NO",DIR("A")="Save as your default view? "
 . D ^DIR I $D(DIRUT)!$D(DIROUT)!(Y=0) Q
 . D SAVE
 ;
 S VALMBCK="R"
 ;
END Q
 ;
DISPLAY ; - Displays the current view
 N LN,PSOPRIEN,PRFDAT,PREFS
 S PSOPRIEN=+$O(^PS(52.35,"B","ERX HOLDING QUEUE PREFERENCES",0)) I 'PSOPRIEN Q
 ;
 I $D(^PS(52.35,PSOPRIEN,"SPV",DUZ)) D
 . D GETS^DIQ(52.352,DUZ_","_PSOPRIEN_",","1;2;3;4;5;6","IE","PRFDAT")
 . M PREFS=PRFDAT(52.352,DUZ_","_PSOPRIEN_",")
 . W !?5,"Your saved default view:"
 . S $P(LN,"-",24)="" W !?5,LN
 . W !?5,"LOOK BACK DAYS      : ",$G(PREFS(1,"E"))," DAYS"
 . W !?5,"SORT BY             : ",$G(PREFS(2,"E"))
 . W !?5,"SORT ORDER          : ",$G(PREFS(3,"E"))
 . W !?5,"DISPLAY DETAILS     : ",$G(PREFS(4,"E"))
 . W !?5,"GROUP BY CS/NON-CS  : ",$G(PREFS(5,"E"))
 . W !?5,"INCLUDE ALL STATUSES: ",$G(PREFS(6,"E"))
 . W !
 Q 
 ;
GOTO(INPUT,HOME) ; - Directed up-arrow
 N GOTO,TAG,TRGT
 I $P(INPUT,"^",2)="" S PSOQUIT=1 Q "EXIT"
 ;
 S TRGT=$P(INPUT,"^",2)
 S TAG("LOOK BACK DAYS")="LKBKD"
 S TAG("SORT BY")="SRTBY"
 S TAG("SORT ORDER")="ORDER"
 S TAG("DISPLAY DETAILS")="DETDP"
 S TAG("GROUP BY STATUS")="GRPCS"
 S TAG("INCLUDE ALL STATUSES")="ALLST"
 ;
 S GOTO=HOME
 S TAG="" F  S TAG=$O(TAG(TAG)) Q:TAG=""  I $E(TAG,1,$L(TRGT))=TRGT S GOTO=TAG(TAG) Q
 I GOTO=HOME W "   ??",$C(7)
 ;
 Q GOTO
 ;
LOAD ; Loading Factory/Division/User preferences for Single Patient View
 ;Output: PSOLKBKD - Look Back Days
 ;        PSOSRTBY - Sort By
 ;        PSORDER - Sort Order ("A":Asc,"D":Desc)
 ;        PSODETDP - Display Details (1:ON/0:OFF)
 ;        PSOCSGRP - Group by Status (1:ON/0:OFF)
 ;        PSOALLST - Include All Statuses (1:ON/0:OFF)
 ; - 'Factory' Defaults
 I $G(RESETLBD)!'$G(PSOLKBKD)!($G(PSOSTFLT)="WP") D
 . S PSOLKBKD=365
 . I $$GET1^DIQ(59,PSOSITE,10.2) S PSOLKBKD=$$GET1^DIQ(59,PSOSITE,10.2)
 S PSOSRTBY="RE",PSORDER="A",PSOALLST=0,(PSOCSGRP,PSODETDP)=0
 ; 
 N PSOPRIEN
 S PSOPRIEN=+$O(^PS(52.35,"B","ERX HOLDING QUEUE PREFERENCES",0)) I 'PSOPRIEN Q
 ;
 ; - User's preferences
 I $D(^PS(52.35,PSOPRIEN,"SPV",DUZ,0)) D SET Q
 ;
 Q
 ;
CHANGED(FIELD,VALUE) ; - Sets PSOCHNG so the list can be refreshed
 ;        FIELD - Field to be checked if was changed/edited
 ;        VALUE - New Value for the field
 I $G(PSOCHNG) Q
 ;
 N PSOPRIEN,PRFDAT,PREFS
 S PSOPRIEN=+$O(^PS(52.35,"B","ERX HOLDING QUEUE PREFERENCES",0)) I 'PSOPRIEN Q
 ; - Saved User's preferences
 D GETS^DIQ(52.352,DUZ_","_PSOPRIEN_",","1;2;3;4;5;6","IE","PRFDAT")
 M PREFS=PRFDAT(52.352,DUZ_","_PSOPRIEN_",")
 ;
 I FIELD="LKBKD",VALUE'=$G(PREFS(1,"I")) S PSOCHNG=1 Q
 I FIELD="SRTBY",VALUE'=$G(PREFS(2,"I")) S PSOCHNG=1 Q
 I FIELD="ORDER",VALUE'=$G(PREFS(3,"I")) S PSOCHNG=1 Q
 I FIELD="DETDP",VALUE'=$G(PREFS(4,"I")) S PSOCHNG=1 Q
 I FIELD="GRPCS",VALUE'=$G(PREFS(5,"I")) S PSOCHNG=1 Q
 I FIELD="ALLST",VALUE'=$G(PREFS(6,"I")) S PSOCHNG=1 Q
 ;
 Q
 ;
SET ; Sets Preferences Variables
 N PSOPRIEN,PRFDAT,PREFS
 S PSOPRIEN=+$O(^PS(52.35,"B","ERX HOLDING QUEUE PREFERENCES",0)) I 'PSOPRIEN Q
 D GETS^DIQ(52.352,DUZ_","_PSOPRIEN_",","1;2;3;4;5;6","I","PRFDAT")
 M PREFS=PRFDAT(52.352,DUZ_","_PSOPRIEN_",")
 I $G(PSOSTFLT)'="WP",$G(RESETLBD) S X=$G(PREFS(1,"I")) I X'="" S PSOLKBKD=X
 S X=$G(PREFS(2,"I")) I X'="" S PSOSRTBY=X
 S X=$G(PREFS(3,"I")) I X'="" S PSORDER=X
 S X=$G(PREFS(4,"I")) I X'="" S PSODETDP=X
 S X=$G(PREFS(5,"I")) I X'="" S PSOCSGRP=X
 S X=$G(PREFS(6,"I")) I X'="" S PSOALLST=X
 Q
 ;
SAVE ; - Saves User's Preferences
 N DIE,DR,DA,PSOPRIEN
 ;
 S PSOPRIEN=+$O(^PS(52.35,"B","ERX HOLDING QUEUE PREFERENCES",0)) I 'PSOPRIEN Q
 ;
 W !!,"Saving..."
 ;
 I '$D(^PS(52.35,PSOPRIEN,"SPV",DUZ,0)) D
 . N %,DIC,DR,DA,X,DINUM,DLAYGO,DD,DO
 . S DIC="^PS(52.35,"_PSOPRIEN_",""SPV"","
 . S DA(1)=PSOPRIEN,(DINUM,X)=DUZ,DIC(0)=""
 . K DD,DO D FILE^DICN K DD,DO
 ;
 S DR="1///"_PSOLKBKD_";2///"_PSOSRTBY_";3///"_PSORDER
 S DR=DR_";4///"_PSODETDP_";5///"_PSOCSGRP_";6///"_PSOALLST
 ;
 S DIE="^PS(52.35,"_PSOPRIEN_",""SPV"",",DA(1)=PSOPRIEN,DA=DUZ
 D ^DIE H 1 W "OK!" H .5
 Q
 ;
DELETE ; - Deletes user/division preferences
 N DIK,DA,DIE,DR
 ;
 W !!,"Deleting..."
 ;
 S DIK="^PS(52.35,"_PSOPRIEN_",""SPV"",",DA(1)=PSOPRIEN,DA=DUZ
 D ^DIK H 1 W "OK!"
 Q
