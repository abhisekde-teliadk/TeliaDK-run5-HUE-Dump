 select strleft(forreign_circuit,2) technology,
    case
        when (cast(speed_down as int) / 1024) >= 0.144 AND (cast(speed_down as int) / 1024) < 2 then 'speed_144_2'
        when (cast(speed_down as int) / 1024) >= 2 AND (cast(speed_down as int) / 1024) < 10 then 'speed_2_10'
        when (cast(speed_down as int) / 1024) >= 10 AND (cast(speed_down as int) / 1024) < 30 then 'speed_10_30'
        when (cast(speed_down as int) / 1024) >= 30 AND (cast(speed_down as int) / 1024) < 50 then 'speed_30_50'
        when (cast(speed_down as int) / 1024) >= 50 AND (cast(speed_down as int) / 1024) < 100 then 'speed_50_100'
        when (cast(speed_down as int) / 1024) >= 100 AND (cast(speed_down as int) / 1024) < 300 then 'speed_100_300'
        when (cast(speed_down as int) / 1024) >= 300 AND (cast(speed_down as int) / 1024) < 500 then 'speed_300_500'
        when (cast(speed_down as int) / 1024) >= 500 AND (cast(speed_down as int) / 1024) < 1024 then 'speed_500_1Gb'
        when (cast(speed_down as int) / 1024) >= 1024 then 'speed_1Gb_plus'
        when (cast(speed_down as int) / 1024) is null then 'speed_undefined'
    end as speed_down_category,
    
    case
        when (cast(speed_up as int) / 1024) >= 0.144 AND (cast(speed_up as int) / 1024) < 2 then 'speed_144_2'
        when (cast(speed_up as int) / 1024) >= 2 AND (cast(speed_up as int) / 1024) < 10 then 'speed_2_10'
        when (cast(speed_up as int) / 1024) >= 10 AND (cast(speed_up as int) / 1024) < 30 then 'speed_10_30'
        when (cast(speed_up as int) / 1024) >= 30 AND (cast(speed_up as int) / 1024) < 50 then 'speed_30_50'
        when (cast(speed_up as int) / 1024) >= 50 AND (cast(speed_up as int) / 1024) < 100 then 'speed_50_100'
        when (cast(speed_up as int) / 1024) >= 100 AND (cast(speed_up as int) / 1024) < 300 then 'speed_100_300'
        when (cast(speed_up as int) / 1024) >= 300 AND (cast(speed_up as int) / 1024) < 500 then 'speed_300_500'
        when (cast(speed_up as int) / 1024) >= 500 AND (cast(speed_up as int) / 1024) < 1024 then 'speed_500_1Gb'
        when (cast(speed_up as int) / 1024) >= 1024 then 'speed_1Gb_plus'
        when (cast(speed_up as int) / 1024) is null then 'speed_undefined'
    end as speed_up_category,
    
    *
    
    from
    
        (
        select
            telia_circuit_id,
            forreign_circuit,
            if(profile_down_speed<>'undef', profile_down_speed,if(access_down_speed<>'undef',access_down_speed,actual_down_speed )) speed_down,
            if(profile_up_speed<>'undef', profile_up_speed,if(access_up_speed<>'undef',access_up_speed,actual_up_speed )) speed_up
        --    nvl(nvl(profile_up_speed,access_up_speed ), actual_up_speed) speed_up
        
            from    
            (
            select 
            tnid_circuit_number telia_circuit_id,
            tnid_foreign_reference forreign_circuit,
            tnid_profile_speed, -- what was provided or sold, this is the highest priority, then access then actual
            tnid_access_speed, -- flex related speed
            tnid_actual_speed, -- what was measured
            
            strleft(tnid_profile_speed, instr(tnid_profile_speed, '/')-1)  profile_down_speed, 
            strright(tnid_profile_speed,length(tnid_profile_speed) -  instr(tnid_profile_speed, '/')) profile_up_speed,
            
            
            strleft(tnid_access_speed, instr(tnid_access_speed, '/')-1) access_down_speed, 
            strright(tnid_access_speed,length(tnid_access_speed) -  instr(tnid_access_speed, '/')) access_up_speed,
            
            
            strleft(tnid_actual_speed, instr(tnid_actual_speed, '/')-1) actual_down_speed, 
            strright(tnid_actual_speed,length(tnid_actual_speed) -  instr(tnid_actual_speed, '/')) actual_up_speed
            
            from base.import_other_sources_base_tnid_extract
            ) priority_speed
        ) clean_speed
-- where technology = 'CN'
;

select * from base.import_other_sources_base_tnid_extract;

select * from work.contr_obligations_tdc_tnid_extract_speed_prep;
select * from work.contr_obligations_tdc_tbt_circuit_tnid_speeds;
