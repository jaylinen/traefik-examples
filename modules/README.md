# Træfik

Reverse Proxyjen ilkeä pikkuveli

---

## Træfik

<!-- .slide: data-state="primary-theme" -->

- Tehty GO:lla, virallinen Docker image 20Mt
- Konfiguroidaan TOML:illa
- Ensimmäinen versio kesäkuussa 2016
- Pääkehittäjä Emily Vauge / Containous
- Helmikuussa 2017 1 miljoona kehitystyöhön
- Versiot on nimetty juustojen mukaan Reblochon, Camembert, Morbier

---

## Etuja

<!-- .slide: data-state="primary-theme" -->

- foobar

---

## Terminologia

<!-- .slide: data-state="primary-theme" -->

- Entypoint
- Frontend
- Backend

Graafinen käyttöliittymä näiden monitorointiin

Notes:

- Entrypoint: HTTP(S) ja portin numero
- Frontend: Kasa sääntöjä joilla pyynnöt ohjataan entrypointista bäkkärille
- Backend: Bäckend on itse palvelu

---

## Terminologia

<!-- .slide: data-state="primary-theme" -->

![Terminologia](https://github.com/containous/traefik/blob/master/docs/img/architecture.png?raw=true)

- Entypoint
- Frontend
- Backend

---

## Demo
