//A page that is not extended with extension fields.
page 50111 JLEsLight
{
    ApplicationArea = Jobs;
    Caption = 'JLEsLight';
    DataCaptionFields = "Job No.";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Entry';
    SourceTable = "Job Ledger Entry";
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Jobs;
                    Editable = false;
                    ToolTip = 'Specifies the posting date for the entry.';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = Jobs;
                    Editable = false;
                    ToolTip = 'Specifies the type of the entry. There are two types of entries:';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Jobs;
                    Editable = false;
                    ToolTip = 'Specifies the document number on the job ledger entry.';
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = Jobs;
                    Editable = false;
                    ToolTip = 'Specifies the number of the job.';
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the number of the related job task.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the type of account to which the job ledger entry is posted.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Jobs;
                    Editable = false;
                    ToolTip = 'Specifies the description of the job ledger entry.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the variant of the item on the line.';
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    Editable = false;
                    ToolTip = 'Specifies the relevant location code if an item is posted.';
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies which work type the resource applies to. Prices are updated based on this entry.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Jobs;
                    ToolTip = 'Specifies the quantity that was posted on the entry.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Jobs;
                    Editable = false;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                }
            }
        }
    }
}

