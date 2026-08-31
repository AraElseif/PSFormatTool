@{
    RootModule              ='PSFormatTool.psm1'
    ModuleVersion           ='0.1.1'
    GUID                    ='3d526ee7-a6d5-476a-bec5-15f86a279beb'
    Author                  ='AraElseif'
    PowerShellVersion       ='5.1'
    CompatiblePSEditions    =@('Desktop', 'Core')
    Description             ='PowerShell module for automated volume formatting'
    FunctionsToExport       =@(
        'New-FormatVolume'
    )
    RequiredModules         =@()
}