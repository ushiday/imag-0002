     H****************************************************************
     H* CRTBNDRPG PGM(USHIDA/USR402V) 
     H*  SRCSTMF('/home/ushiday/src/vs-code/rpg/USR402V.rpgle') 
     H*  TEXT(' ＶＳ－ＣＯＤＥテスト ') 
     H*  TGTCCSID(*JOB)
     H****************************************************************
     H*-------------------------------*
     H*----<< 日付 >>-----*
     H*-------------------------------*
     H DATEDIT(*YMD)
     H COPYRIGHT('(C) ushiday - ')
     H*-------------------------------*
     H*----<<コンパイル条件>>-----*
     H*-------------------------------*
     H DFTACTGRP(*NO) ACTGRP(*NEW)
     H OPTION(*NOUNREF)
     H BNDDIR('QC2LE')
     F*----<<ファイル定義>>-----*
     FITEM      IF   E           K DISK
     D*----<<変数定義>>-----*
     D*
     D REC           E DS                  EXTNAME(ITEM : *INPUT)
     D                                     QUALIFIED
     D                                     ALIAS
     D*
     D print           PR                  EXTPROC('print')
     D    msg                      1000A   VARYING CONST
     C*-------------------------------*
     C*----<<メインルーチン>>-----*
     C*-------------------------------*
      /FREE
           print ('プログラム開始') ;

           //�ǎ��
           READ ITEM REC  ;

           IF %EOF ;
               print ('レコードなし') ;
           ELSE  ;
               print ('商品名は' + REC.ITEM_NAME   )    ;
           ENDIF ;

           print ('プログラム終了') ;
           *INLR = *ON    ;
           RETURN        ;

      /END-FREE
     P****************************************************************
     P** < print             >: 標準出力                            **
     P****************************************************************
     P print           B                   EXPORT
     D print           PI
     D    msg                      1000A   VARYING CONST
     D printf          PR              *   EXTPROC('printf')
     D    template                     *   VALUE OPTIONS(*STRING)
     D    string                       *   VALUE OPTIONS(*STRING)
     D    dummy                        *   VALUE OPTIONS(*NOPASS)
     D*
     D NEWLINE         C                   X'15'
     D*タイムスタンプ
     D WTIMESTAMP      S               Z
     D WDATE8          S              8S 0
     D WTIME6          S              6S 0
      /FREE
          WTIMESTAMP = %TIMESTAMP()   ;
          WDATE8     = %DEC(%DATE(WTIMESTAMP) : *ISO );
          WTIME6     = %DEC(%TIME(WTIMESTAMP) : *HMS );
          printf ( %EDITW(WTIME6:'  :  :  ')+ ' %s' + NEWLINE : msg) ;
      /END-FREE
     P                 E
