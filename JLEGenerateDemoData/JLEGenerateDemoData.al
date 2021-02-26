//generating 1.000.000 of records in Job Ledger Entry Table
report 50100 JLEGenerateDemoData
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = TableData "Job Ledger Entry" = rm;

    trigger OnPreReport()
    var
        Job: Record Job;
        JobPlanningLine: Record "Job Planning Line";
        JobLedgerEntry: Record "Job Ledger Entry";
        i: Integer;
        j: Integer;
        InsertingEntriesTxt: Label 'Inserting entries @1@@@@@@@@@@@@@';
        Window: Dialog;
        NoOfRecords: Integer;
        OldDateTime: DateTime;
        NewDateTime: DateTime;
        NewProgress: Integer;
        OldProgress: Integer;
        NextEntryNo: Integer;
    begin
        NextEntryNo := JobLedgerEntry.GetLastEntryNo();
        Window.Open(InsertingEntriesTxt);
        NoOfRecords := 333000;
        OldDateTime := CurrentDateTime;

        for i := 1 to NoOfRecords do begin
            NewDateTime := CurrentDateTime;
            if (NewDateTime - OldDateTime > 10000) or (NewDateTime < OldDateTime) then begin
                NewProgress := Round(i / NoOfRecords * 100, 1);
                if NewProgress <> OldProgress then begin
                    Window.Update(1, NewProgress * 100);
                    OldProgress := NewProgress;
                end;
                OldDateTime := CurrentDateTime;
            end;
            for j := 1 to 3 do begin
                Job.FindSet();
                Job.Next(j - 1);
                JobPlanningLine.SetRange("Job No.", Job."No.");
                JobPlanningLine.FindFirst();
                JobLedgerEntry.Init();
                NextEntryNo += 1;
                JobLedgerEntry."Entry No." := NextEntryNo;
                JobLedgerEntry."Job No." := JobPlanningLine."Job No.";
                JobLedgerEntry."Job Task No." := JobPlanningLine."Job Task No.";
                JobLedgerEntry."Posting Date" := WorkDate();
                JobLedgerEntry."Document Date" := WorkDate();
                JobLedgerEntry."Document No." := 'TESTMILIONRECS';
                JobLedgerEntry.Type := JobPlanningLine.Type;
                JobLedgerEntry."No." := JobPlanningLine."No.";
                JobLedgerEntry.Description := JobPlanningLine.Description;
                JobLedgerEntry.Quantity := 1;
                JobLedgerEntry."Quantity (Base)" := 1;
                JobLedgerEntry."Qty. per Unit of Measure" := 1;
                JobLedgerEntry."Unit Price" := JobPlanningLine."Unit Price";
                JobLedgerEntry."Unit Cost (LCY)" := JobPlanningLine."Unit Price (LCY)";
                JobLedgerEntry."Total Price" := JobPlanningLine."Unit Price";
                JobLedgerEntry."Total Price (LCY)" := JobPlanningLine."Total Price (LCY)";
                JobLedgerEntry."Line Amount" := JobLedgerEntry."Total Price";
                JobLedgerEntry."Line Amount (LCY)" := JobLedgerEntry."Total Price (LCY)";
                JobLedgerEntry."Unit of Measure Code" := JobPlanningLine."Unit of Measure Code";
                JobLedgerEntry."Entry Type" := JobLedgerEntry."Entry Type"::Usage;
                JobLedgerEntry."Ledger Entry Type" := "Job Ledger Entry Type"::Resource;
                JobLedgerEntry.Insert();
            end;
            Commit();
        end;
    end;
}