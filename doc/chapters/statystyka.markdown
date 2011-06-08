# Analiza otrzymanych wyników w programie SAS

Otrzymane wyniki symulacji zostały zapisane kolejno w plikach `strategia0.txt`,
`strategia1.txt` oraz `strategia2.txt`. Zawierają one zarobek sklepu
internetowego, zarejestrowany po określonym czasie. Ważnym faktem jest to, że
symulacja każdej strategii przyniosła rożne rezultaty.

W celu przeprowadzenia analizy zarobków, które zostały uzyskane podczas
wielokrotnej symulacji, wykorzystaliśmy skrypt napisany w programie SAS,
znajdujący się na stronie Zakładu Systemów Komputerowych. Odrobinę zmieniliśmy
formę, aby umożliwił nam odczytania pożądanych przez nas wartości, dzięki
którym zdołaliśmy określić, która strategia jest najkorzystniejsza. Dane
wejściowe dla skryptu `analiza.sas` znajdywały się w plikach, które zostały
wyżej wymienione. Każdy z nich zawierał stan zarobkowy, który sklep posiadał w
określonej chwili. Przykładowy fragment pliku `strategia0.txt`.

    14477
    10833
    11575
    11300
    13120
    11780
    13381
    13192
    9695
    12017

Symulacja była przeprowadzana dla systemu, w którym brak towaru oznaczał stratę
pieniężną. Zaproponowane zostały trzy strategie, każda różniącą się znaczącą od
innych, w celu różnorodnego rozpatrzenia przedstawionego problemu. Dzięki
programie SAS potrafimy stwierdzić, która strategia jest najodpowiedniejsza i
przynosi największe zyski oraz największa wydajność systemu.

Poniżej przestawiam kod skryptu `analiza.sas`.

    data results err_log;

    /* wczytanie danych z pliku */
    infile 'strategia2.txt';
        input sample;
            if _error_ then output err_log;
            else output results;
    run;
    title 'Testowanie rozkładu normalnego';
        proc capability data=results normaltest;
            var sample;
        run;

    /* rysowanie dystrybuanty empirycznej */
    title 'Dystrybuanta empiryczna ';
        legend1 frame cframe=yellow cborder=black position=center;
    proc capability data = results noprint;

        cdfplot sample;
    run;

    /* rysowanie histogramów zawierających zaznaczoną gęstość prawdopodobieństwa
       dla rozkładów weibulla, normalnego i wykładniczego */

    title 'Histogram';
    proc capability data = results noprint;
    histogram / weibull(color=green w=2) normal(color=yellow w=2) exponential(color = red w=2);

    run;

    /* rysowanie trzech wykresów probabilistycznych dla rozkładu wykładniczego,
       normalnego oraz weibulla */
    title 'Probability Plot';
    proc capability data = results noprint;
         probplot sample /  exponential(sigma=est theta=est);
         probplot sample /  normal(mu=est sigma=est);
         probplot sample / weibull(theta=0.0 sigma=est c=est color=yellow
    w=2);

    run;

W wyniku działania skryptu otrzymujemy pięć obrazów dla każdej strategii,
dzięki którym możemy stwierdzić rodzaj rozkładu prawdopodobieństwa.
Przechodzimy teraz do przedstawienia wyników analizy dla każdej strategii.

\begin{figure}[hbtp]
  \begin{center}
    \includegraphics[scale=.45]{images/strategia0/centyle_normalne.png}
  \end{center}
  \caption{\label{centyle_normalne0}Strategia 0}
\end{figure}

\begin{figure}[hbtp]
  \begin{center}
    \includegraphics[scale=.45]{images/strategia1/centyle_normalne.png}
  \end{center}
  \caption{\label{centyle_normalne1}Strategia 1}
\end{figure}

\begin{figure}[hbtp]
  \begin{center}
    \includegraphics[scale=.45]{images/strategia2/centyle_normalne.png}
  \end{center}
  \caption{\label{centyle_normalne2}Strategia 2}
\end{figure}

Na wykresach \ref{centyle_normalne0}, \ref{centyle_normalne1} oraz
\ref{centyle_normalne2} znajduje się dopasowanie wyników do rozkładu normalnego.

Analizując wykresy probabilistyczne rozkładu normalnego zauważyliśmy, że
dopasowanie jest bardzo zbliżone do idealnego wzorca. Wyjątkiem jest strategia
numer 0, w której widać znaczne odstępstwa. Przejdźmy do analizy rozkładu
wykładniczego.

\begin{figure}[hbtp]
  \begin{center}
    \includegraphics[scale=.45]{images/strategia0/centyle_wykladnicze.png}
  \end{center}
  \caption{\label{centyle_wykladnicze0}Strategia 0}
\end{figure}

\begin{figure}[hbtp]
  \begin{center}
    \includegraphics[scale=.45]{images/strategia1/centyle_wykladnicze.png}
  \end{center}
  \caption{\label{centyle_wykladnicze1}Strategia 1}
\end{figure}

\begin{figure}[hbtp]
  \begin{center}
    \includegraphics[scale=.45]{images/strategia2/centyle_wykladnicze.png}
  \end{center}
  \caption{\label{centyle_wykladnicze2}Strategia 2}
\end{figure}

Na wykresach \ref{centyle_wykladnicze0}, \ref{centyle_normalne1} oraz
\ref{centyle_wykladnicze2} znajduje się dopasowanie wyników do rozkładu
wykładniczego.

Widząc przedstawione wyżej trzy wykresy łatwo jest zauważyć, że rozkład
wykładniczy całkowicie nie jest dopasowany do naszej symulacji. Nie będziemy go
brać pod uwagę, podczas wybierania odpowiedniej strategii dla naszego
symulatora. Kolejnym etapem była analiza rozkładu Weibulla.

Ważnym faktem jest to, że dla strategii numer jeden, program SAS nie generował
wykresu dla rozkładu Weibulla. Patrząc na dwa pozostałe wykresy, możemy śmiało
stwierdzić, że dopasowanie nie jest wystarczające.

\begin{figure}[hbtp]
  \begin{center}
    \includegraphics[scale=.45]{images/strategia0/centyle_weibulla.png}
  \end{center}
  \caption{\label{centyle_weibulla0}Strategia 0}
\end{figure}

\begin{figure}[hbtp]
  \begin{center}
    \includegraphics[scale=.45]{images/strategia2/centyle_weibulla.png}
  \end{center}
  \caption{\label{centyle_weibulla2}Strategia 2}
\end{figure}

Na wykresach \ref{centyle_weibulla0} oraz
\ref{centyle_weibulla2} znajduje się dopasowanie wyników do rozkładu Weibulla.

Ważnym faktem, jest to, że dla strategii numer jeden, program SAS nie
generował wykresu dla rozkładu Weibulla. Patrząc na dwa pozostałe wykresy,
możemy śmiało stwierdzić, że dopasowanie nie jest wystarczające.

## Histogramy wraz z zaznaczona gęstością rozkładów prawdopodobieństwa

\begin{figure}[hbtp]
  \begin{center}
    \includegraphics[scale=.4]{images/strategia0/histogram.png}
  \end{center}
  \caption{\label{histogram0}Strategia 0}
\end{figure}

\begin{figure}[hbtp]
  \begin{center}
    \includegraphics[scale=.4]{images/strategia1/histogram.png}
  \end{center}
  \caption{\label{histogram1}Strategia 1}
\end{figure}

\begin{figure}[hbtp]
  \begin{center}
    \includegraphics[scale=.4]{images/strategia2/histogram.png}
  \end{center}
  \caption{\label{histogram2}Strategia 2}
\end{figure}

Dokonując analizy przedstawionych na wykresach (\ref{histogram0},
\ref{histogram1} i \ref{histogram2}) histogramów odrzucamy na samym wstępie
rozkład wykładniczy, ponieważ w żaden sposób nie odzwierciedla on
przybliżonego dopasowania. Zostało nam rozstrzygnięcie kwestii czy wybrać
rozkład Weibulla lub rozkład normalny. Opierając się na wykresach
probabilistycznych przedstawionych wcześniej, zdecydowaliśmy się, że
najlepszym dopasowanie jest rozkład normalny. Mimo tego, że w strategii numer
0, w niektórych miejscach znacząco odbiegał od idealnego dopasowania, to w
strategiach 1 i 2 dopasowanie było niemal idealne. Rozkład Weibulla w żadnym z
przypadków nie był tak blisko dopasowania jak rozkład normalny.

