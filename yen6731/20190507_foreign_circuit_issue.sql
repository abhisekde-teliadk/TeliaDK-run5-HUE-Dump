SELECT * FROM finance.abt_circuit_bridge WHERE foreign_circuit = 'FB-1529845';

SELECT * FROM work.contr_obligations_tdc_work_geneva_product_event_source WHERE foreign_circuit = 'FB-1529845';

select * from base.import_other_sources_base_tnid_extract where tnid_foreign_reference='FB-1529845';

select * from work.contr_obligations_tdc_work_techinfo_tnid_fo_joined WHERE foreign_circuit = 'FB-1529845';

select * from work.contr_obligations_tdc_work_techinfo_tnid_steno WHERE foreign_circuit = 'FB-1529845';

select * from work.contr_obligations_tdc_work_techinfo_tnid_steno_geneva_stacked WHERE foreign_circuit = 'FB-1529845';