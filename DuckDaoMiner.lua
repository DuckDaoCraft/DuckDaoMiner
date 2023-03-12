local component = require("component")
local gpu = component.gpu

-- Überprüfen, ob eine GPU verfügbar ist
if not gpu or not component.isAvailable("gpu") then
  io.stderr:write("Dieses Programm benötigt eine GPU zum Ausführen.")
  return
end

-- Setzen der Monitor-Auflösung
gpu.setResolution(40, 10)

-- Startwerte für Hasrate und generierte DuckDaos setzen
local hashrate = 900
local duckdaos = 0

-- Euro-Kurs festlegen
local euroRate = 2.34
-- Hintergrund- und Textfarben setzen
gpu.setBackground(0xFFA500)
gpu.setForeground(0x000000)

-- Schleife, die kontinuierlich die Hashrate, generierte DuckDaos und Euro-Wert aktualisiert
while true do
  -- Aktualisieren der Hasrate zwischen 800-1500 H/s
  local gpuCount = 0
  for address, _ in component.list("gpu", true) do
    gpuCount = gpuCount + 1
  end
  hashrate = math.random(800, 1500) + gpuCount * 1500 - 1500 + math.random(-300, 300)

  -- Generieren von zwischen 0.01-0.05 DuckDaos pro GPU
  duckdaos = duckdaos + gpuCount * (math.random() * 0.04 + 0.01)

  -- Berechnen des Euro-Werts der generierten DuckDaos
  local euroValue = duckdaos * euroRate

  -- Löschen des Bildschirms und Anzeigen der aktualisierten Werte
  gpu.fill(1, 1, 40, 10, " ")
  gpu.set(1, 1, "+--------------------------------------+")
  gpu.set(1, 2, "|  DuckDao Mining                      |")
  gpu.set(1, 3, "+--------------------------------------+")
  gpu.set(1, 4, "|  DuckDaos Generiert: "..string.format("%.3f", duckdaos).."            |")
  gpu.set(1, 5, "|  Hashrate: "..hashrate.." H/s                   |")
  gpu.set(1, 6, "|  DuckDaos in Euro: "..string.format("%.2f", euroValue).." EUR         |")
  gpu.set(1, 7, "+--------------------------------------+")
  gpu.set(1, 8, "|  DuckDaoMinerV3 DuckDaoCraft ©      |")
  gpu.set(1, 9, "+--------------------------------------+")

  -- Warten für 1 Sekunde, bevor die Werte erneut aktualisiert werden
  os.sleep(1)
end
