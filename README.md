
# Direktkreditverwaltung

Diese Version der Direktkreditverwaltung ist darauf ausgelegt, Nachrangdarlehen an Vereine zu verwalten. GmbH's wie im Mietshäusersyndikat spielen hier keine Rolle.

## Allgemein

Zinsberechnung nach der "Deutschen Methode" 30/360 (mit der days360-Methode nach "The European Method (30E/360)"). Siehe http://de.wikipedia.org/wiki/Zinssatz#Berechnungsmethoden und http://en.wikipedia.org/wiki/360-day_calendar.

Die Berechnungsmethode kann durch Editieren von `config/settings.yml` auf `act_act` geändert werden. (Note: Currently not implemented!)

#### Verwaltung

Verwaltet:

* Kontaktdaten
* Verträge
* Versionen von Verträgen (Laufzeiten und Zinssatz kann sich ändern)
* Buchungen

#### Funktionen

* Kontoauszüge
* Zinsberechnungen
* Vertragsübersicht nach Auslaufdatum
* Jahresabschluss (die Zinsen eines Jahres auf Konto gutschreiben)
* Vertrag auflösen (zum Stichtag den Auszahlungsbetrag inkl. Zinsen berechnen)

#### Imports

Import von:

* Kontakten
    * `$ rake import:contacts[/path/to/csv_file.csv]`
* Direktkreditverträgen
    * `$ rake import:contracts[/path/to/csv_file.csv]`
    * Kontakte und DK-Verträge werden verlinkt wenn den DK-Verträgen Namen zugeordnet sind
* Buchungseinträgen möglich
    * `$ rake import:accounting_entries[/path/to/csv_file.csv]`

(benötigtes Format der csv-Dateien ist in lib/tasks/import.rake beschrieben)

#### pdf-Ausgabe

* ist verfügbar für die Zinsübersicht, Zinsbriefe und Dankesbriefe
* kann mit Bildern und Textsnippets im Verzeichnis custom angepasst werden
* die &lt;Dateiname&gt;\_template-Vorlagen in diesem Verzeichnis müssen in eine Datei &lt;Dateiname&gt; kopiert werden und dann editiert.

#### latex-Ausgabe

* z.B. die Zinsauswertung lässt sich im latex-Format ausgeben. Diese kann dann gespeichert, modifiziert und mit latex, dvipdfm, ... weiter verarbeitet werden
* die latex-Ausgabe ist der pdf-Ausgabe vorzuziehen, wenn die Möglichkeit der latex-Datei-Manipulation vor der pdf-Erstellung nötig ist
* Templates für die Zinsbriefe befinden sich in /app/views/layouts und /app/views/contracts . Sie enden auf "\_template". Kopiere die \_template-Dateien in Dateien mit gleichem Namen jedoch ohne "\_template" und ändere die die Dateien wo nötig.
* Parameter für dvipdfm: -p a4 (Papiergröße), -l (Landscape mode für Dankesbriefe)

## Konfiguration

* Der Standardtyp der Verträge ist "Integer". Falls ein "String" benötigt wird (z.B. bei Vertragsnamen wie "2-05-001"), muss die config/settings.yml angepasst werden:
```
contract_number_type: "string" # one of: "string" | "integer", defaults to integer
```

## Geplant sind

* Graphen

## Bekannte Fehler

* Löschen von Verträgen sollte Vertragsversionen, Buchungen, ... mitlöschen

## Setup

### Voraussetzungen

* docker
* docker-compose

### Installation

* 'config/database.yml_template_sqlite3' und 'config/settings.yml_template' anpassen
* 'docker-compose up'

### Backup

* ist noch nicht implementiert, die 'db/*.sqlite3'-Dateien können aber einfach händisch gesichert werden.

### Tests

1. `$ rake db:migrate`
2. `$ rake db:test:prepare`
3. `$ rake test` (to run a single test: `$ ruby -I test <path/to/testfile>`)
3. `$ rake cucumber`

### API docs

* create via: `$ rake doc:app`

### Laufenden Container betreten

* 'docker-compose exec web bash'
