Direktkreditverwaltung
======================

Nach Erfordernissen eines Mietshäuser Syndikat Projekts.

Zinsberechnung nach der "Deutschen Methode" 30/360 (mit der days360-Methode nach "The European Method (30E/360)")(ich finde es auch schrecklich, aber so ist es üblich). Siehe http://de.wikipedia.org/wiki/Zinssatz#Berechnungsmethoden und http://en.wikipedia.org/wiki/360-day_calendar
Die Berechnungsmethode kann durch Editieren von config/settings.yml auf act_act geändert werden.

Verwaltet
* Kontaktdaten
* Verträge
* Versionen von Verträgen (Laufzeiten und Zinssatz kann sich ändern)
* Buchungen

Erstellt
* Kontoauszüge
* Zinsberechnungen
* Vertragsübersicht nach Auslaufdatum

Import
* von Kontakten 
    * rake import:contacts[/path/to/csv_file.csv]
* Buchungseinträgen möglich
    * rake import:accounting_entries[/path/to/csv_file.csv]
(benötigtes Format der csv-Dateien ist in lib/tasks/import.rake beschrieben)

latex-Ausgabe
* z.B. die Zinsauswertung lässt sich im latex-Format ausgeben. Diese kann dann gespeichert, modifiziert und mit latex, dvipdfm, ... weiter verarbeitet werden
* es wurde kein pdf-export gewählt, um die Möglichkeit der latex-Datei-Manipulation zu bewahren
* Templates für die Zinsbriefe befinden sich in /app/views/layouts und /app/views/contracts . Sie enden auf "_template". Kopiere die _template-Dateien in Dateien mit gleichem Namen jedoch ohne "_template" und ändere die die Dateien wo nötig.
* Parameter für dvipdfm: -p a4 (Papiergröße), -l (Landscape mode für Dankesbriefe) 

Geplant sind 
* Graphen

Bekannte Fehler
* Löschen von Verträgen sollte Vertragsversionen, Buchungen, ... mitlöschen

