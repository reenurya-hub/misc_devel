       IDENTIFICATION DIVISION.
       PROGRAM-ID. SFTIDF1.
      * CREATE AN INDEXED FILE FROM A SEQUENTIAL FILE
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      * PROVS.DAT IS PHYSICAL SEQUENTIAL FILE.
       SELECT LFPROVS ASSIGN TO "PROVS.DAT"
        ORGANIZATION IS LINE SEQUENTIAL.
      * IDFPROVS.DAT IS NEW INDEXED FILE.
       SELECT LFIDFPROVS ASSIGN TO "IDFPROVS.DAT"
        FILE STATUS IS FILE-CHECK-KEY
        ORGANIZATION IS INDEXED
        ACCESS MODE IS RANDOM
        RECORD KEY IS IDFPROV-ID
        ALTERNATE RECORD KEY IS IDFPROV-DESC
        WITH DUPLICATES.
       
       DATA DIVISION.
       FILE SECTION.
       FD LFPROVS.
       01 PROVSRECORD.
           88 ENDOFFILE       VALUE HIGH-VALUES.
           03 PROV-ID             PIC 9(10).
           03 PROV-DESC           PIC X(40).
           03 PROV-BAL            PIC 9(10).
       
       FD LFIDFPROVS.
       01 LFIDFPROVSRECORD.
           03 IDFPROV-ID             PIC 9(10).
           03 IDFPROV-DESC           PIC X(40).
           03 IDFPROV-BAL            PIC 9(10).
       
       WORKING-STORAGE SECTION.
       
       01  WS-WORK-AREAS.
           05  FILE-CHECK-KEY   PIC X(2).
           05  IDFPROV-KEY     PIC 999.
       
       PROCEDURE DIVISION.
       
       0100-READ-LFPROVS.
       
		   OPEN INPUT LFPROVS.
		   OPEN OUTPUT LFIDFPROVS.
		   				
           READ LFPROVS 
		     AT END SET ENDOFFILE TO TRUE
		   END-READ.
		   PERFORM 0200-PROCESS-FILE UNTIL
		      ENDOFFILE.
		 
		   PERFORM 9000-END-PROGRAM.

	   0200-PROCESS-FILE.
          
		   WRITE LFIDFPROVSRECORD FROM PROVSRECORD
		      INVALID KEY DISPLAY 
			     "FILE STATUS = " FILE-CHECK-KEY
		   END-WRITE.
		   READ LFPROVS
		      AT END SET ENDOFFILE TO TRUE.
          
       9000-END-PROGRAM.
           CLOSE LFPROVS.
           CLOSE LFIDFPROVS.
           STOP RUN.  
       END PROGRAM SFTIDF1. 
