       IDENTIFICATION DIVISION.
       PROGRAM-ID. SRTRF1.
      * CREATE A RELATIVE FILE FROM A SEQUENTIAL FILE
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      * PROVS.DAT IS PHYSICAL SEQUENTIAL FILE.
       SELECT LFPROVS ASSIGN TO "PROVS.DAT"
        ORGANIZATION IS LINE SEQUENTIAL.
      * RFPROVS.DAT IS NEW RELATIVE SEQUENTIAL FILE.
       SELECT LFRFPROVS ASSIGN TO "RFPROVS.DAT"
        ORGANIZATION IS RELATIVE
        ACCESS MODE IS SEQUENTIAL
        RELATIVE KEY IS RFPROV-KEY.
       
       DATA DIVISION.
       FILE SECTION.
       FD LFPROVS.
       01 PROVSRECORD.
           88 ENDOFFILE       VALUE HIGH-VALUES.
           03 PROV-ID             PIC 9(10).
           03 PROV-DESC           PIC X(40).
           03 PROV-BAL            PIC 9(10).
       
       FD LFRFPROVS.
       01 LFRFPROVSRECORD.
           03 RFPROV-ID             PIC 9(10).
           03 RFPROV-DESC           PIC X(40).
           03 RFPROV-BAL            PIC 9(10).
       
       WORKING-STORAGE SECTION.
       
       01  WS-WORK-AREAS.
           05  FILE-CHECK-KEY   PIC X(2).
           05  RFPROV-KEY     PIC 999.
       
       PROCEDURE DIVISION.
       
       0100-READ-LFPROVS.
       
		   OPEN INPUT LFPROVS.
		   OPEN OUTPUT LFRFPROVS.
		   				
           READ LFPROVS 
		     AT END SET ENDOFFILE TO TRUE
		   END-READ.
		   PERFORM 0200-PROCESS-FILE UNTIL
		      ENDOFFILE.
		 
		   PERFORM 9000-END-PROGRAM.

	   0200-PROCESS-FILE.
          
		   MOVE PROVSRECORD TO 
		      LFRFPROVSRECORD.
		   WRITE LFRFPROVSRECORD
		      INVALID KEY DISPLAY 
			     "STUDIOS STATUS = " FILE-CHECK-KEY
                 DISPLAY RFPROV-ID
		   END-WRITE.
          
		   READ LFPROVS
		      AT END SET ENDOFFILE TO TRUE.
          
       9000-END-PROGRAM.
           CLOSE LFPROVS.
           CLOSE LFRFPROVS.
           STOP RUN.  
       END PROGRAM SRTRF1. 