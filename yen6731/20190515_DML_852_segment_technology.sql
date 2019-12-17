select distinct * from analytics.abt_edi_accounting where segment is null;

select distinct segment_technology from base.import_other_sources_base_edi_extract;

select distinct strleft(tdc_circuit_id,2) from base.import_other_sources_base_edi_extract where segment_technology='Consumer';
select distinct strleft(tdc_circuit_id,2) from base.import_other_sources_base_edi_extract where segment_technology='Technology';

select distinct strleft(tdc_circuit_id,2) from base.import_other_sources_base_edi_extract where segment_technology='Enterprise' order by 1;

select distinct strleft(tdc_circuit_id,2) from base.import_other_sources_base_edi_extract where segment_technology is null;


select distinct segment, segment_technology, strleft(tdc_circuit_id,2) from finance.abt_edi_accounting where segment_technology='Consumer';
select distinct segment, segment_technology, strleft(tdc_circuit_id,2) from finance.abt_edi_accounting where segment_technology='Technology';

select distinct segment, segment_technology, strleft(tdc_circuit_id,2) from finance.abt_edi_accounting where segment_technology='Enterprise' order by 1;

select distinct segment, segment_technology, strleft(tdc_circuit_id,2) from finance.abt_edi_accounting where segment_technology is null;