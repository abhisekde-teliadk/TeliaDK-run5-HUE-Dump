select distinct invoice_date from raw.import_other_sources_base_edi_extract;

select distinct invoice_date from raw.import_other_sources_raw_edi_extract where invoice_date like '%JUN2019' order by invoice_date desc;
