#!/usr/bin/ruby -w

# gesamtzahl der Postings zunaechst auf 0 setzen
postings = 0
# Aktuelle Position auf 0 setzen
pos = 0
# Anzahldatei vorhanden?
if File.file?("postings.txt")
  # Anzahl auslesen
  f = File.open("postings.txt", "r")
  postings = f.gets.to_i
  f.close
  # Aktuelle Position entspricht zunaechst Anzahl
  pos = postings
end
# Hauptschleife
loop do
  # Bildschirm loeschen -- plattformabhaengig
  if RUBY_PLATFORM =~ /win/
     system "cls"
   else
     system "clear"
   end
   # Fuenf Eintraege ab pos ausgeben, falls vorhanden
   if postings > 0
     puts "Bisherige Eintraege"
     puts "==================="
     puts
     # Letzter anzuzeigender Eintrag
    last = pos - 4
    last = 1 if last < 1
    # Iterator: umgekehrte Reihenfolge
    pos.downto(last) { |i|
    printf "%d. -- ", i
    # Aktuelle Datei oeffnen
    fname = "post#{i}.txt"
    f = open(fname, "r")
    # Gesamten Inhalt auslesen und ausgeben
    post = f.read
    puts post
    puts "-------------------"
    f.close
    }
   else
     puts "Noch keine Eintraege."
   end
   # Menue anzeigen
   puts
   print "AUSWAHL: "
   print "(N)euere " if pos < postings
   print "(A)eltere " if pos > 5
   print "(S)chreiben (E)nde\n"
   print "===> "
   # Menueauswahl
   wahl = gets.chomp
   # Beenden
   break if wahl =~ /^e/i
     # Neuere Postings
     if wahl =~ /^n/i
       pos += 5
       pos = postings if pos > postings
       next
     end
     # Aeltere Postings
     if wahl =~ /^a/i
      pos -= 5
      pos = 1 if pos < 1
    next
  end
  # Eingabe eines neuen Eintrags
  puts "Neuen Eintrag zeilenweise eingeben,
  leere Zeile zum Fertigstellen"
  # Anzahl und Position erhoehen
  postings += 1
  pos = postings
  # Neue Datei zum Schreiben oeffnen
  fname = "post#{postings}.txt"
  f = File.open(fname, "w")
  # Datum/Uhrzeit als erste Zeile erzeugen
  t = Time.new
  eintrag = t.strftime("%d.%m.%Y, %H:%M")
  # Schleife, bis Eintrag leerer String ist
  while eintrag != ""
    # Eintrag in die Datei schreiben
    f.puts eintrag
    # Neue Zeile einlesen
    eintrag = gets.chomp
end
# Datei schliessen
f.close
# Neue Anzahl eintragen
f = File.open("postings.txt", "w")
f.puts postings
f.close
end
