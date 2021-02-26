//generating 1.000.000 of records in a related Table
report 50106 JLEGenerateDemoData6
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    trigger OnPreReport()
    var
        JobLedgerEntry: Record "Job Ledger Entry";
        JLE6: Record JLE6;
        i: Integer;
        InsertingEntriesTxt: Label 'Inserting entries @1@@@@@@@@@@@@@';
        Window: Dialog;
        NoOfRecords: Integer;
        OldDateTime: DateTime;
        NewDateTime: DateTime;
        NewProgress: Integer;
        OldProgress: Integer;
    begin
        Window.Open(InsertingEntriesTxt);
        NoOfRecords := JobLedgerEntry.Count;
        OldDateTime := CurrentDateTime;
        if JobLedgerEntry.FindSet() then
            repeat
                i += 1;
                NewDateTime := CurrentDateTime;
                if (NewDateTime - OldDateTime > 1000) or (NewDateTime < OldDateTime) then begin
                    NewProgress := Round(i / NoOfRecords * 100, 1);
                    if NewProgress <> OldProgress then begin
                        Window.Update(1, NewProgress * 100);
                        OldProgress := NewProgress;
                    end;
                    OldDateTime := CurrentDateTime;
                end;
                JLE6.ValidateField(JobLedgerEntry, JLE6.FieldNo("Ext field 6"), JobLedgerEntry."Job No.");
                Commit();
            until JobLedgerEntry.Next() = 0;
    end;
}