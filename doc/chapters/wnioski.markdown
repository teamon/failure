# Wnioski

Instrukcje typu SIMD zostały wprowadzone, aby umożliwić szybkie przetwarzanie
multimediów takich jak dźwięk i obraz. Dzięki SIMD można uzyskać przyspieszenie
podczas operacji na tablicach ze względu na fakt, że operacje przeprowadzane są
wektorowo. Nie zawsze łatwo jest zapisać algorytm w taki sposób, aby można było
korzystać z dobrodziejstw instrukcji SIMD. Wadą MMX jest fakt, że wykorzystuje
rejestry FPU i nie można korzystać w tym samym czasie z jednostki
zmiennoprzecinkowej oraz MMX.

