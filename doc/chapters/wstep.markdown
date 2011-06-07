# Wstęp

Zadaniem było napisanie programu wykorzystującego technologie SIMD, takie jak
MMX. Opisywany program pozwala wykonać dwie operacje na dźwięku -- odwrócenie
próbki, czyli odtwarzanie sygnału od tyłu, oraz konwersja dźwięku stereo do
mono. Program potrafi operować na plikach dźwiękowych typu `wave`, w których
sygnał nie został skompresowany.

Program działa na systemie GNU/Linux oraz wymaga urządzenia wirtualnego
`/dev/dsp`^[W większości systemów nie jest ono dostępne domyślnie i należy
doinstalować pakiet \texttt{alsa-oss}]. Program testowałem na systemie Arch
Linux (kernel 2.6.38), kompilator GCC 4.6. Do funkcji, w których umieściłem
wstawki asemblerowe, dodałem atrybut `optimize(0)`, dzięki czemu optymalizator
nie będzie próbował optymalizować tych funkcji. Należy pamiętać, że atrybut ten
jest tylko rozszerzeniem kompilatora i nie wszystkie kompilatory biorą go pod
uwagę.

