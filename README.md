# LCM-GCD
NTUST assembly language

![](https://github.com/naiyu0609/LCM-GCD/blob/main/%E7%B5%90%E6%9E%9C.PNG)

首先利用ch6學習到的巨集pstring、pchar跟getkey來讀取並顯示鍵盤敲入的數字，而因為敲入的數字為ASCII碼，所以要減30h再合成數字，但組語是利用16進制，所以要再將十位數乘以0Ah再加個位數才會是16進制。

接下來就是比較部分(此部分我標記為L1)，因為我不知道使用者輸入的數字先後是大是小，所以要先比較大小，才能知道要不要先交換再去輾轉相除；而輾轉相除與交換的部分是利用JUMP的方式去處理，我把除法部分標記L2交換部分標記L3，若一開始是大於就接下來執行L2，但若不是就JUMP到L3交換再JUMP到L2。

輾轉相除是兩數相除後，再利用餘數與原本的除數相除到最後出現0才停止，所以此部分要L2與L3互相JUMP，直到餘數為0，再利用判斷是否為0 JUMP到L4。

L4的部分為求LCM與將LCM、GCD轉入十進制，首先因為有一開始的兩個數字，然後利用L2與L3求得的GCD就可以求得LCM；而將LCM與GCD轉十進制就必須利用除以0Ah去計算出十進制的表示方式。

L5的部分為將LCM與GCD印出，這部分是利用ch2所學到的shift的方式與add 30h的方式將每個數字印出。L5執行完後又會JUMP回L1重新執行一次，所以這個程式除非按ESC，不然會一直無限循環。

![](https://github.com/naiyu0609/LCM-GCD/blob/main/%E6%B5%81%E7%A8%8B%E5%9C%96.PNG)
