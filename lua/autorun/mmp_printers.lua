gPrinterVersion = 1.0
gAuthorDiscord = "realmephistopheles"


if SERVER then
    print("###########################################")
    print("Initialization of Mephisto's Custom Printers")
    print("Starting Server Side")
    print(string.format("Addon Version : %s", gPrinterVersion))
    print(string.format("Made By Mephisto | Discord : %s", gAuthorDiscord))
    print("###########################################")
end

if CLIENT then
    return 
end