BEGIN{ a = 0.0 ; i = 0 ; max = -999999999  ; min = 9999999999 }
{
    i ++
    a += $1
    if ( $1 > max ) max = $1
    if ( $1 < min ) min = $1
}
END{ printf("---\n%10s  %8d\n%10s  %15f\n%10s  %15f\n%10s  %15f\n%10s  %15f\n%10s  %15f\n","items:",i,"max:",max,"min:",min,"sum:",a,"mean:",a/(i*1.0),"mean/max:",(a/(i*1.0))/max) }
