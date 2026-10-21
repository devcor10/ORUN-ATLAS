using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using System;

namespace ATLAS.App.ViewModels;

public partial class MainWindowViewModel : ObservableObject
{
    [ObservableProperty]
    private string unitName = "POD A-3 — HOUSING UNIT MANAGEMENT";

    [ObservableProperty]
    private string sentinelStatus = "POST ACTIVE";

    [ObservableProperty]
    private bool hasException;

    [ObservableProperty]
    private string exceptionTitle = "KEEP-SEPARATE COLLISION";

    [ObservableProperty]
    private string exceptionDetail = "Bunk 12 and Recreation Group B — two inmates marked separate.";

    [ObservableProperty]
    private string currentTime = DateTime.Now.ToString("HH:mm:ss");

    [ObservableProperty]
    private string countDisplay = "COUNT 48 / 48";

    public MainWindowViewModel()
    {
        // Demo: raise exception after a short delay or on command
        HasException = false;
    }

    [RelayCommand]
    private void ClearException()
    {
        HasException = false;
    }

    [RelayCommand]
    private void RaiseException()
    {
        HasException = true;
    }
}
