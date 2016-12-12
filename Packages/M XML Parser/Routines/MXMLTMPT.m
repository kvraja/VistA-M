MXMLTMPT   ; VEN/GPL/SMH-OSEHRA/JPS - XML Templater TEST CASES ;2015-06-11  04:00 PM
 ;;2.4;XML PROCESSING UTILITIES;;June 15, 2015;Build 14
 ; (c) George Lilly 2010-2013
 ; (c) Sam Habiel 2014
 ;
TEST ; M-Unit Entry point for Unit Testing
 S IO=$PRINCIPAL
 N DIQUIET S DIQUIET=1
 D DT^DICRW
 D:$L($T(EN^%ut))&$L($T(^MXMLTMP1)) EN^%ut($T(+0),1)
 QUIT
 ;
STARTUP ; M-Unit Start-up
 QUIT
 ;
SHUTDOWN ; M-Unit Stop
 QUIT
 ;
SETUP ; M-Unit each Step set-up
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 K MXMLARR0,MXMLARR1,MXMLARR2
 DO INITXML0,INITXML1,INITXML2
 QUIT
 ;
TEARDOWN ; M-Unit each Step Tear-down
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 K MXMLARR0,MXMLARR1,MXMLARR2
 QUIT
 ;
INITXML0 ; Init 1
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 D PUSH^MXMLTMP1($NA(MXMLARR0),"FIRST")
 D PUSH^MXMLTMP1($NA(MXMLARR0),"SECOND")
 D PUSH^MXMLTMP1($NA(MXMLARR0),"THIRD")
 D PUSH^MXMLTMP1($NA(MXMLARR0),"FOURTH")
 QUIT
 ;
INITXML1 ; Init 2
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 D PUSH^MXMLTMP1($NA(MXMLARR1),"<FIRST>")
 D PUSH^MXMLTMP1($NA(MXMLARR1),"<SECOND>")
 D PUSH^MXMLTMP1($NA(MXMLARR1),"<THIRD>")
 D PUSH^MXMLTMP1($NA(MXMLARR1),"<FOURTH>@@DATA1@@</FOURTH>")
 D PUSH^MXMLTMP1($NA(MXMLARR1),"<FIFTH>")
 D PUSH^MXMLTMP1($NA(MXMLARR1),"@@DATA2@@")
 D PUSH^MXMLTMP1($NA(MXMLARR1),"</FIFTH>")
 D PUSH^MXMLTMP1($NA(MXMLARR1),"<SIXTH ID=""SELF"" />")
 D PUSH^MXMLTMP1($NA(MXMLARR1),"</THIRD>")
 D PUSH^MXMLTMP1($NA(MXMLARR1),"<SECOND>")
 D PUSH^MXMLTMP1($NA(MXMLARR1),"</SECOND>")
 D PUSH^MXMLTMP1($NA(MXMLARR1),"</SECOND>")
 D PUSH^MXMLTMP1($NA(MXMLARR1),"</FIRST>")
 QUIT
INITXML2 ; Init 3
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 D PUSH^MXMLTMP1($NA(MXMLARR2),"<FIRST>")
 D PUSH^MXMLTMP1($NA(MXMLARR2),"<SECOND>")
 D PUSH^MXMLTMP1($NA(MXMLARR2),"<THIRD>")
 D PUSH^MXMLTMP1($NA(MXMLARR2),"<FOURTH>DATA1</FOURTH>")
 D PUSH^MXMLTMP1($NA(MXMLARR2),"<FOURTH>")
 D PUSH^MXMLTMP1($NA(MXMLARR2),"DATA2")
 D PUSH^MXMLTMP1($NA(MXMLARR2),"</FOURTH>")
 D PUSH^MXMLTMP1($NA(MXMLARR2),"</THIRD>")
 D PUSH^MXMLTMP1($NA(MXMLARR2),"<_SECOND>")
 D PUSH^MXMLTMP1($NA(MXMLARR2),"<FOURTH>DATA3</FOURTH>")
 D PUSH^MXMLTMP1($NA(MXMLARR2),"</_SECOND>")
 D PUSH^MXMLTMP1($NA(MXMLARR2),"</SECOND>")
 D PUSH^MXMLTMP1($NA(MXMLARR2),"</FIRST>")
 QUIT
 ;
PUSH ; @TEST - Test PUSH
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 D CHKEQ^%ut(MXMLARR0(0),4,"Only 4 elements were expected.")
 D CHKEQ^%ut(MXMLARR0(MXMLARR0(0)),"FOURTH","Last pushed element should be FOURTH")
 QUIT
 ;
PUSHPOP ; @TEST - Test PUSH and POP
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 N %
 D POP^MXMLTMP1($NA(MXMLARR0),.%)
 D CHKEQ^%ut(%,"FOURTH","Poped element should be FOURTH")
 D CHKEQ^%ut(MXMLARR0(0),3,"Only 3 elements should be left")
 D CHKEQ^%ut(MXMLARR0(MXMLARR0(0)),"THIRD","Last pushed element should be THIRD")
 ;
 N %
 D POP^MXMLTMP1($NA(MXMLARR0),.%)
 D CHKEQ^%ut(%,"THIRD","Poped element should be FOURTH")
 D CHKEQ^%ut(MXMLARR0(0),2,"Only 2 elements should be left")
 D CHKEQ^%ut(MXMLARR0(MXMLARR0(0)),"SECOND","Last pushed element should be THIRD")
 QUIT
 ;
MKMDX ; @TEST - Test MKMDX
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 N %
 D MKMDX^MXMLTMP1($NA(MXMLARR0),.%)
 D CHKEQ^%ut(%,"//FIRST/SECOND/THIRD/FOURTH")
 QUIT
 ;
XNAME ; @TEST - Test XNAME
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 D CHKEQ^%ut($$XNAME^MXMLTMP1("<FOURTH>DATA1</FOURTH>"),"FOURTH","XNAME failed")
 D CHKEQ^%ut($$XNAME^MXMLTMP1("<SIXTH  ID=""SELF"" />"),"SIXTH","XNAME failed")
 D CHKEQ^%ut($$XNAME^MXMLTMP1("</THIRD>"),"THIRD","XNAME failed")
 QUIT
 ;
XVARS ; @TEST - Test XVARS
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 N GTMP,GTMP2
 D PUSH^MXMLTMP1($NA(GTMP),"<VALUE1>@@VAR1@@ and @@VAR1a@@</VALUE1>")
 D PUSH^MXMLTMP1($NA(GTMP),"<VALUE2>nothing to see here</VALUE2>")
 D PUSH^MXMLTMP1($NA(GTMP),"<VALUE3>@@VAR3@@</VALUE3>")
 D XVARS^MXMLTMPL($NA(GTMP2),$NA(GTMP))
 ; ZWRITE GTMP,GTMP2
 D CHKEQ^%ut(GTMP2(1),"^VAR1^1")
 QUIT
 ;
INDEX ; @TEST - Test INDEX
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 D INDEX^MXMLTMP1($NA(MXMLARR1))
 D CHKEQ^%ut(MXMLARR1("//FIRST/SECOND"),"2^12")
 D CHKEQ^%ut(MXMLARR1("//FIRST/SECOND/THIRD"),"3^9")
 D CHKEQ^%ut(MXMLARR1("//FIRST/SECOND/THIRD/FIFTH"),"5^7")
 D CHKEQ^%ut(MXMLARR1("//FIRST/SECOND/THIRD/FOURTH"),"4^4^@@DATA1@@")
 D CHKEQ^%ut(MXMLARR1("//FIRST/SECOND/THIRD/SIXTH"),"8^8^")
 D CHKEQ^%ut(MXMLARR1("//FIRST"),"1^13")
 QUIT
 ;
INDEX2 ; @TEST - Test INDEX ; again
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 D INDEX^MXMLTMP1($NA(MXMLARR2))
 D CHKEQ^%ut(MXMLARR2("//FIRST/SECOND"),"2^12")
 D CHKEQ^%ut(MXMLARR2("//FIRST/SECOND/_SECOND"),"9^11")
 D CHKEQ^%ut(MXMLARR2("//FIRST/SECOND/_SECOND/FOURTH"),"10^10^DATA3")
 D CHKEQ^%ut(MXMLARR2("//FIRST/SECOND/THIRD"),"3^8")
 D CHKEQ^%ut(MXMLARR2("//FIRST/SECOND/THIRD/FOURTH[1]"),"4^4^DATA1")
 D CHKEQ^%ut(MXMLARR2("//FIRST"),"1^13")
 QUIT
 ;
MISSING ; @TEST - Test MISSING (@@element@@ that need to be filled out)
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 K ^TMP($J)
 D MISSING^MXMLTMPL($NA(MXMLARR1),$NA(^TMP($J,"MISSINGTEST")))
 D CHKEQ^%ut(^TMP($J,"MISSINGTEST",1),"DATA1")
 D CHKEQ^%ut(^TMP($J,"MISSINGTEST",2),"DATA2")
 K ^TMP($J)
 QUIT
 ;
MAP ; @TEST - Test MAP. Maps values to missing elements.
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 K ^TMP($J)
 N MAPARY S MAPARY=$NA(^TMP($J,"MAPVALUES"))
 N OUTARY S OUTARY=$NA(^TMP($J,"MAPTEST"))
 S @MAPARY@("DATA2")="VALUE2"
 D MAP^MXMLTMPL($NA(MXMLARR1),MAPARY,OUTARY)
 ; ZWRITE @OUTARY@(*)
 D CHKEQ^%ut(@OUTARY@(6),"VALUE2")
 K ^TMP($J)
 QUIT
 ;
MAP2 ; @TEST - Test MAP for multiple values.
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 K ^TMP($J)
 N MAPARY S MAPARY=$NA(^TMP($J,"MAPVALUES"))
 N OUTARY S OUTARY=$NA(^TMP($J,"MAPTEST"))
 S @MAPARY@("DATA1")="VALUE1"
 S @MAPARY@("DATA2")="VALUE2"
 S @MAPARY@("DATA3")="VALUE3"
 S MXMLARR1(4)="<FOURTH>@@DATA1@@ AND @@DATA3@@</FOURTH>"
 D MAP^MXMLTMPL($NA(MXMLARR1),MAPARY,OUTARY)
 ; D PARY^MXMLTMPL(OUTARY)
 D CHKEQ^%ut(@OUTARY@(4),"<FOURTH>VALUE1 AND VALUE3</FOURTH>")
 K ^TMP($J)
 QUIT
 ;
QUEUE ; @TEST - Test QUEUE - Adds entries to build list
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 N BTLIST
 D QUEUE^MXMLTMPL($NA(BTLIST),$NA(MXMLARR1),2,3)
 D QUEUE^MXMLTMPL($NA(BTLIST),$NA(MXMLARR1),4,5)
 ; ZWRITE BTLIST
 D CHKEQ^%ut($P(BTLIST(2),";",2),4)
 QUIT
 ;
QUERY ; @TEST - Test XPATH-like QUERY
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 N G2
 D QUERY^MXMLTMPL($NA(MXMLARR1),"//FIRST/SECOND/THIRD/FOURTH",$NA(G2))
 D CHKEQ^%ut(G2(1),"<FOURTH>@@DATA1@@</FOURTH>")
 QUIT
 ;
BUILD ; @TEST - Test Build return off QUEUE[d] lists..
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 N BTLIST
 D QUEUE^MXMLTMPL($NA(BTLIST),$NA(MXMLARR1),2,3)
 D QUEUE^MXMLTMPL($NA(BTLIST),$NA(MXMLARR1),4,5)
 N G3
 D BUILD^MXMLTMPL($NA(BTLIST),$NA(G3))
 ;ZWRITE MXMLARR1,BTLIST,G3
 D CHKEQ^%ut(G3(4),"<FIFTH>")
 QUIT
 ;
CP ; @TEST - Copy Arrays
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 N G2
 D CP^MXMLTMPL($NA(MXMLARR1),$NA(G2))
 ;ZWRITE G2
 D CHKEQ^%ut(G2(0),13)
 QUIT
 ;
QOPEN ; @TEST - Create build list to copy all lines except last
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 N GBL
 D QOPEN^MXMLTMPL($NA(GBL),$NA(MXMLARR1))
 ;ZWRITE MXMLARR1
 ;ZWRITE GBL
 D CHKEQ^%ut($P(GBL(1),";",3),12)
 N DEST ; destination
 D BUILD^MXMLTMPL($NA(GBL),$NA(DEST))
 ;ZWRITE DEST
 D CHKEQ^%ut(DEST(DEST(0)),"</SECOND>")
 QUIT
 ;
QOPEN2 ; @TEST - Create partial build list to copy XPATH contents
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 N GBL
 D QOPEN^MXMLTMPL($NA(GBL),$NA(MXMLARR1),"//FIRST/SECOND")
 ;ZWRITE MXMLARR1,GBL
 N G2
 D BUILD^MXMLTMPL($NA(GBL),$NA(G2))
 D CHKEQ^%ut(G2(G2(0)),"</SECOND>")
 QUIT
 ;
QCLOSE ; @TEST - Create build list to copy last line
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 N GBL
 D QCLOSE^MXMLTMPL($NA(GBL),$NA(MXMLARR1))
 ;ZWRITE MXMLARR1,GBL
 N G2
 D BUILD^MXMLTMPL($NA(GBL),$NA(G2))
 D CHKEQ^%ut(G2(G2(0)),"</FIRST>")
 QUIT
QCLOSE2 ; @TEST - Create build list to copy last line based off XPATH
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 N GBL,G2
 D QCLOSE^MXMLTMPL($NA(GBL),$NA(MXMLARR1),"//FIRST/SECOND/THIRD")
 ;ZWRITE MXMLARR1,GBL
 D CHKEQ^%ut($P(GBL(1),";",3),13)
 D BUILD^MXMLTMPL($NA(GBL),$NA(G2))
 D CHKEQ^%ut(G2(G2(0)),"</FIRST>")
 D CHKEQ^%ut(G2(1),"</THIRD>")
 QUIT
INSERT ; @TEST - Test insertion of XML at end of XPATH
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 N GBL,G2,G3,G4
 D QUERY^MXMLTMPL($NA(MXMLARR1),"//FIRST/SECOND/THIRD/FIFTH",$NA(G2))
 ; ZWRITE MXMLARR1,G2
 D INSERT^MXMLTMPL($NA(MXMLARR1),$NA(G2),"//FIRST/SECOND/THIRD")
 ; ZWRITE MXMLARR1
 ; ZWRITE G2
 ; ZWRITE:$D(G3) G3
 D INSERT^MXMLTMPL($NA(G3),$NA(G2),"//")
 D CHKEQ^%ut(G2(1),MXMLARR1(9))
 QUIT
REPLACE ; @TEST - Test REPLACE of XML
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 N G2
 D QUERY^MXMLTMPL($NA(MXMLARR1),"//FIRST/SECOND/THIRD/FIFTH",$NA(G2))
 ; ZWRITE MXMLARR1,G2
 D REPLACE^MXMLTMPL($NA(MXMLARR1),$NA(G2),"//FIRST/SECOND")
 ; ZWRITE MXMLARR1
 D CHKEQ^%ut(MXMLARR1(2),"<FIFTH>")
 QUIT
 ;
INSINNER ; @TEST - Test Insert Inner source XML into end of dest XML XPATH
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 N G2
 D QUERY^MXMLTMPL($NA(MXMLARR1),"//FIRST/SECOND/THIRD",$NA(G2))
 ; ZWRITE MXMLARR1,G2
 D INSINNER^MXMLTMPL($NA(MXMLARR1),$NA(G2),"//FIRST/SECOND/THIRD")
 ; ZWRITE MXMLARR1
 D CHKEQ^%ut(MXMLARR1(10),"<FIFTH>")
 QUIT
INSINNE2 ; @TEST - Test Insert Inner source XML into end of dest XML
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 N G2
 D QUERY^MXMLTMPL($NA(MXMLARR1),"//FIRST/SECOND/THIRD",$NA(G2))
 ;ZWRITE G2
 D INSINNER^MXMLTMPL($NA(G2),$NA(G2))
 ;ZWRITE G2
 D CHKEQ^%ut(G2(8),"<FIFTH>")
 QUIT
PUSHA ; @TEST - Push All
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 N GTMP,GTMP2
 D PUSH^MXMLTMP1($NA(GTMP),"A")
 D PUSH^MXMLTMP1($NA(GTMP2),"B")
 D PUSH^MXMLTMP1($NA(GTMP2),"C")
 D PUSHA^MXMLTMP1($NA(GTMP),$NA(GTMP2))
 ; ZWRITE GTMP,GTMP2
 D CHKEQ^%ut(GTMP(3),"C")
 D CHKEQ^%ut(GTMP(0),3)
 QUIT
H2ARY ; @TEST - Convert a Hash to a return array (return(n)="key^value")
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 N GTMP,GTMP2
 S GTMP("TEST1")=1
 S GTMP("TEST2")=4
 S GTMP("TEST3")=8
 D H2ARY^MXMLTMPL($NA(GTMP2),$NA(GTMP))
 D CHKEQ^%ut(GTMP2(0),3)
 D CHKEQ^%ut(GTMP2(2),"^TEST2^4")
 QUIT
 ;
TRIM ; @TEST - Trim an XML array
 ; ZEXCEPT: MXMLARR0,MXMLARR1,MXMLARR2
 N MXMLARR0
 D PUSH^MXMLTMP1($NA(MXMLARR0),"<Books>")
 D PUSH^MXMLTMP1($NA(MXMLARR0),"<Book>")
 D PUSH^MXMLTMP1($NA(MXMLARR0),"<Title>Pride and Prejudice</Title>")
 D PUSH^MXMLTMP1($NA(MXMLARR0),"<Author></Author>")
 D PUSH^MXMLTMP1($NA(MXMLARR0),"<Length>")
 D PUSH^MXMLTMP1($NA(MXMLARR0),"</Length>")
 D PUSH^MXMLTMP1($NA(MXMLARR0),"</Book>")
 D PUSH^MXMLTMP1($NA(MXMLARR0),"</Books>")
 D TRIM^MXMLTMP1($NA(MXMLARR0))
 D CHKEQ^%ut(MXMLARR0(0),5)
 ZWRITE MXMLARR0
 QUIT
 ;
 ;
 ;
DEMO ; Demo program.
 ;
CREATE ; Create Template
 N MXMLTEMPLATE
 D PUSH^MXMLTMP1($NA(MXMLTEMPLATE),$$XMLHDR^MXMLUTL())
 D PUSH^MXMLTMP1($NA(MXMLTEMPLATE),"<Books>")
 D PUSH^MXMLTMP1($NA(MXMLTEMPLATE),"<LastUpdated date=""@@LASTUP@@"" />")
 D PUSH^MXMLTMP1($NA(MXMLTEMPLATE),"<Book>")
 D PUSH^MXMLTMP1($NA(MXMLTEMPLATE),"<Author>@@AUTHOR@@</Author>")
 D PUSH^MXMLTMP1($NA(MXMLTEMPLATE),"<Title>@@TITLE@@</Title>")
 D PUSH^MXMLTMP1($NA(MXMLTEMPLATE),"<Description>@@DES@@</Description>")
 D PUSH^MXMLTMP1($NA(MXMLTEMPLATE),"</Book>")
 D PUSH^MXMLTMP1($NA(MXMLTEMPLATE),"</Books>")
 Q
PARY1 ; Print Array
 ; ZEXCEPT: MXMLTEMPLATE
 W "Printing pushed template",!
 D PARY^MXMLTMPL($NA(MXMLTEMPLATE))
 ;
MISS1 ; Print elements needing to be resolved
 N MXMLMISS
 D MISSING^MXMLTMPL($NA(MXMLTEMPLATE),$NA(MXMLMISS))
 ;
PARY11 ; Print Array
 W "Printing unresolved placeholder elements",!
 D PARY^MXMLTMPL($NA(MXMLMISS))
 K MXMLMISS
 ;
MAP1 ; Map the Date
 N DATE S DATE=$$FMTE^XLFDT($$NOW^XLFDT())
 N MXMLHASH S MXMLHASH("LASTUP")=DATE
 K DATE
 ;
 N MXMLOUTPUT
 D MAP^MXMLTMPL($NA(MXMLTEMPLATE),$NA(MXMLHASH),$NA(MXMLOUTPUT))
 K MXMLHASH
 ;
PARY2 ; Print Array
 W !
 W "Printing template with mapped date",!
 D PARY^MXMLTMPL($NA(MXMLOUTPUT))
 W !
 W "Original: ",!
 D PARY^MXMLTMPL($NA(MXMLTEMPLATE))
 ;
SWAP ; Swap the output into the original
 K MXMLTEMPLATE
 M MXMLTEMPLATE=MXMLOUTPUT
 K MXMLOUTPUT
 ;
QUERY1 ; Grab the books parts to use as a repeating segment
 N MXMLBOOKSXML
 D QUERY^MXMLTMPL($NA(MXMLTEMPLATE),"//Books/Book",$NA(MXMLBOOKSXML))
 ;
PARY3 ; Print Array
 W !,"Printing the Books XML segement",!
 D PARY^MXMLTMPL($NA(MXMLBOOKSXML))
 ;
MAP3 ; Make second map
 N MXMLHASH
 S MXMLHASH("AUTHOR")="Lord Byron"
 S MXMLHASH("TITLE")="Don Juan"
 S MXMLHASH("DES")="A swipe at the traditional Don Juan story, the hero goes clueless into various adventures and many romantic conquests"
 N MXMLOUTPUTLB
 D MAP^MXMLTMPL($NA(MXMLBOOKSXML),$NA(MXMLHASH),$NA(MXMLOUTPUTLB))
 K MXMLHASH
 ;
PARY4 ; Print Array
 W !,"Printing Mapped Book segment",!
 D PARY^MXMLTMPL($NA(MXMLOUTPUTLB))
 ;
REPLACE1 ; Replace the original Books segment with the new segment
 D REPLACE^MXMLTMPL($NA(MXMLTEMPLATE),$NA(MXMLOUTPUTLB),"//Books/Book")
 K MXMLOUTPUT
 ;
PARY5 ; Print Array
 W !,"Printing original template after mapped segment is inserted",!
 D PARY^MXMLTMPL($NA(MXMLTEMPLATE))
 ;
MAP4 ; Make another book map
 N MXMLHASH
 S MXMLHASH("AUTHOR")="Samuel Butler"
 S MXMLHASH("TITLE")="The way of all Flesh"
 S MXMLHASH("DES")="A semi-autobiographical novel which attacks Victorian-era hypocrisy."
 N MXMLOUTPUTSB
 D MAP^MXMLTMPL($NA(MXMLBOOKSXML),$NA(MXMLHASH),$NA(MXMLOUTPUTSB))
 K MXMLHASH
 ;
PARY6 ; Print Array
 W !,"Printing Mapped Book segment",!
 D PARY^MXMLTMPL($NA(MXMLOUTPUTSB))
 ;
INSINN1 ; Insert inner portion of Books XML before the end of the Books section
 D INSINNER^MXMLTMPL($NA(MXMLTEMPLATE),$NA(MXMLOUTPUTSB),"//Books/Book")
 ;
PARY7 ; Print Array
 W !,"Printing original template after second mapped section is inserted",!
 D PARY^MXMLTMPL($NA(MXMLTEMPLATE))
 W !,"Incorrect XML produced",!
 ;
DEL1 ; Delete Books section
 D REPLACE^MXMLTMPL($NA(MXMLTEMPLATE),"","//Books/Book")
 ;
PARY8 ; Print Array
 W !,"Printing a template without the books section which just got deleted."
 D PARY^MXMLTMPL($NA(MXMLTEMPLATE))
 W !,"Printing both mapped arrays",!
 D PARY^MXMLTMPL($NA(MXMLOUTPUTLB))
 D PARY^MXMLTMPL($NA(MXMLOUTPUTSB))
 ;
INSINN2 ; Insert inner portion of Books XML again of Byron's Don Juan
 D INSINNER^MXMLTMPL($NA(MXMLTEMPLATE),$NA(MXMLOUTPUTLB),"//Books/Book")
 ;
PARY9 ; Print Array
 W !!,"Printing template with Don Juan"
 D PARY^MXMLTMPL($NA(MXMLTEMPLATE))
 ;
INSERT1 ; Insert all of the Butler's Way of all Flesh into template under Books
 D INSERT^MXMLTMPL($NA(MXMLTEMPLATE),$NA(MXMLOUTPUTSB),"//Books")
 ;
PARY0 ; Print Array
 W !!,"Printing template with both books in it"
 D PARY^MXMLTMPL($NA(MXMLTEMPLATE))
 ;
QUIT QUIT
 ;
PUSHPOP2 ; Push and Pop
 N KBAN
 D PUSH^MXMLTMP1($NA(KBAN),"Test1")
 D PUSH^MXMLTMP1($NA(KBAN),"Test2")
 N KBANVAL
 D POP^MXMLTMP1($NA(KBAN),.KBANVAL)
 W KBANVAL,! ; Test2
 QUIT
 ;
TRIM2 ; - Trim an XML array
 N MXMLARR0
 D PUSH^MXMLTMP1($NA(MXMLARR0),"<Books>")
 D PUSH^MXMLTMP1($NA(MXMLARR0),"<Book>")
 D PUSH^MXMLTMP1($NA(MXMLARR0),"<Title>Pride and Prejudice</Title>")
 D PUSH^MXMLTMP1($NA(MXMLARR0),"<Author></Author>")
 D PUSH^MXMLTMP1($NA(MXMLARR0),"<Length>")
 D PUSH^MXMLTMP1($NA(MXMLARR0),"</Length>")
 D PUSH^MXMLTMP1($NA(MXMLARR0),"</Book>")
 D PUSH^MXMLTMP1($NA(MXMLARR0),"</Books>")
 D TRIM^MXMLTMP1($NA(MXMLARR0))
 ; ZWRITE MXMLARR0
 QUIT