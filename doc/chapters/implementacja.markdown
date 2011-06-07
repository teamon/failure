# Implementacja

W celu uproszczenia operacji na pliku wave po wczytaniu go do pamięci
zdefiniowana została następująca struktura, a przy jej pomocy typ.

    typedef struct wave wave_t;
    struct wave {
        char *data;
        int length;
        int channels;
        int samplerate;
        int bits;
    };

Program składa się z następujących funkcji.

    void usage(void);
    int dsp_init(void);
    int dsp_play(int fd, wave_t *data);
    void dsp_close(int fd);
    wave_t *wave_read(const char *filename);
    void wave_free(wave_t *data);
    wave_t *wave_mono(wave_t *data) __attribute__((optimize(0)));
    wave_t *wave_reverse(wave_t *data) __attribute__((optimize(0)));
    int main(int argc, char **argv);

Pominę opis funkcji `usage`, gdyż nie dzieje się tam nic interesującego z punktu
widzenia laboratorium.

Funkcja `dsp_init` zwraca deskryptor pliku, który zostaje otrzymany po otwarciu
`/dev/dsp`.

Funkcja `dsp_play` odtwarza przekazane jako parametr dane z pliku `wav`. W ten
funkcji ustawione zostają parametry dźwięku takie jak liczba bitów,
częstotliwość próbkowania oraz ilość kanałów. Po ustawieniu tych wartości za
pomocą systemowego wywołania `ioctl` następuje zapis do danych dźwiękowych do
urządzenia `/dev/dsp`. Ostatnie wywołanie funkcji `ioctl` rozpoczyna odtwarzanie
dźwięku.

Funkcja `dsp_close` zdefiniowana została tylko dla kompletności API. W ciele tej
funkcji uruchamiane jest wywołanie systemowe `close` i w razie błędu na
standardowe wyjście błędów wypisywany jest odpowiedni komunikat.

W funkcji `wave_read` tworzona jest instancja typu `wave_t`, do której
wczytywane są dane z pliku, którego nazwa przekazana została jako parametr.
Jeśli funkcja zwraca wartość `NULL` to z jakiegoś powodu wczytanie pliku się nie
powiodło. W razie błędu stosowny komunikat jest wypisywany na standardowe
wyjście błędów.

Funkcja `wave_free` została zdefiniowana dla ułatwienia posługiwania się typem
`wave_t`. Zostaje w niej zwolniony bufor danych PCM oraz pamięć zajmowana przez
strukturę `wave`.

Funkcja `wave_mono` przekodowuje dźwięk stereo na dźwięk mono korzystając z
MMX. Konwersja polega na obliczeniu średniej z próbek prawego i lewego kanału.

Funkcja `wave_reverse` wykorzystuje MMX do odwrócenia kolejności próbek w taki
sposób, aby dźwięk odtwarzany był od tyłu.

W funkcji `main` wykorzystuje funkcję `getopt` do przetworzenia parametrów z
linii komend oraz w zależności od nich wywołuje odpowiednie funkcje.

