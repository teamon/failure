# Implementacja generatora

Generator symulujący składanie zamówień przez klientów sklepu został napisany w
języku Ruby.

Podczas wywołania generator przyjmuje następujące parametry

* `TIME_MAX` -- czas symulacji
* `K` -- ilość produktów dostępnych w sklepie
* `K_MAX` -- początkowa ilość każdego z produktów
* `K_MIN` -- parametry wykorzystywany przez strategie uzupełniające
* `ALGORITHM` -- wybrana strategia uzupełniająca

Na początku symulacji magazyn jest wypełniany `K` produktami po `K_MAX` każdego.
Cena produktu jest równa jego numerowi (produkt nr 5 ma cenę równą 5).
Czas symulacji jest ustawiany na wartość 0. Całkowity zysk sklepu jest również
ustawiany na wartość 0.  Dopóki czas jest mniejszy od ustalonego czasu
maksymalnego (`TIME_MAX`) wykonywane są następujące kroki

* Losowana jest ilość czasu od poprzedniego zamówienia
  (wartość losowa o rozkładzie wykładniczym),
* Losowane są zamawiane produkty (od 1 do K),
* Dla każdego z produktów sprawdzany jest stan magazynu,
* Jeżeli w magazynie nie ma danego produktu zysk sklepu zostaje pomniejszony o
  cenę produktu, w przeciwnym wypadku z magazynu zostaje usunięta jedna sztuka
  danego produktu, a zysk sklepu zostaje powiększony o jego cenę.
* Dla każdego produktu w magazynie sprawdzany jest warunek strategi
  uzupełniającej. Jeżeli warunek jest prawdziwy następuje wywołanie funkcji
  uzupełniającej. Po uzupełnieniu magazynu od całkowitego zysku sklepu
  odejmowana jest wartość ilości uzupełnionych sztuk danego produktu pomnożona
  przez cenę tego produktu.

Na wyjściu generator podaje stan magazynu po każdym zamówieniu jak i aktualny
zysk sklepu. Ostateczną wartością zwracaną przez generator jest całkowity zysk
sklepu po zakończeniu symulacji (po osiągnięciu czasu `TIME_MAX`).

## Strategie uzupełniania

Zdefiniowane zostały trzy następujące strategie

* Strategia 0 -- uzupełnianie stanu magazynu do `K_MAX`, jeśli stan magazynu
  jest mniejszy, bądź równy `K_MIN`,
* Strategia 1 -- uzupełnienie stanu magazynu do wartości dwa razy większej niż
  obecna, gdy w magazynie znajduje się mniej niż `K_MIN` procent z `K_MAX`
  produktów w magazynie,
* Strategia 2 -- uzupełnianie stanu magazynu do `K_MAX` co stały okres czasu
  zdefiniowany za pomocą zmiennej `K_MIN`.

## Generowanie wyników do analizy

W celu wygenerowania wyników napisany został skrypt w języku Ruby, który
automatycznie wywołuje generator dla każdego z algorytmów uzupełniania oraz
zadanych parametrów i wypisuje dane na ekranie.

