SELECT -- TODO: CNI starts with 
  case  
    when  cn_separated_1 IS NULL then tnid_foreign_reference
    else
    cn_separated_1
  end AS tdc_id,

  case  
    when  strleft(tnid_foreign_reference_transposed,2)  = "TN" then tnid_foreign_reference_transposed
    else
    tnid_circuit_number
  end AS telia_id,

  
  *
 
FROM
work.contr_obligations_tdc_work_tnid_extract;