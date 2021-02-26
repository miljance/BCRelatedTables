report 50110 JLEFindSetFilteringOnBaseField
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = TableData "Job Ledger Entry" = rm;
    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field(UseJITLoad; UseJITLoad)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
    var
        UseJITLoad: Boolean;

    trigger OnPreReport()
    var
        Job: Record Job;
        JobLedgerEntry: Record "Job Ledger Entry";
        StartDateTime: DateTime;
        TotalLineAmount: Decimal;
    begin
        StartDateTime := CurrentDateTime;
        if UseJITLoad then
            JobLedgerEntry.SetLoadFields("Line Amount");
        Job.FindFirst();
        JobLedgerEntry.SetRange("Job No.", Job."No.");
        if JobLedgerEntry.FindSet() then
            repeat
                TotalLineAmount += JobLedgerEntry."Line Amount";
            until JobLedgerEntry.Next() = 0;
        Message(Format(CurrentDateTime - StartDateTime));
    end;
}