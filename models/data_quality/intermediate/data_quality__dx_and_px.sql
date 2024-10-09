{{ config(
     enabled = var('data_quality_enabled',var('claims_enabled',var('tuva_marts_enabled',False))) | as_bool
   )
}}

with unpivot_diagnosis as(
        {{ dbt_utils.unpivot(
        relation=ref('medical_claim'),
        cast_to=type_string(),
        exclude=['claim_id', 'diagnosis_code_type'],
        field_name='diagnosis_column',
        value_name='diagnosis_code',
        remove=[   'claim_line_number'
                    , 'claim_type'
                    , 'patient_id'
                    , 'member_id'
                    , 'payer'
                    , 'plan'
                    , 'claim_start_date'
                    , 'claim_end_date'
                    , 'claim_line_start_date'
                    , 'claim_line_end_date'
                    , 'admission_date'
                    , 'discharge_date'
                    , 'admit_source_code'
                    , 'admit_type_code'
                    , 'discharge_disposition_code'
                    , 'place_of_service_code'
                    , 'bill_type_code'
                    , 'ms_drg_code'
                    , 'apr_drg_code'
                    , 'revenue_center_code'
                    , 'service_unit_quantity'
                    , 'hcpcs_code'
                    , 'hcpcs_modifier_1'
                    , 'hcpcs_modifier_2'
                    , 'hcpcs_modifier_3'
                    , 'hcpcs_modifier_4'
                    , 'hcpcs_modifier_5'
                    , 'rendering_npi'
                    , 'rendering_tin'
                    , 'billing_npi'
                    , 'billing_tin'
                    , 'facility_npi'
                    , 'paid_date'
                    , 'paid_amount'
                    , 'allowed_amount'
                    , 'charge_amount'
                    , 'coinsurance_amount'
                    , 'copayment_amount'
                    , 'deductible_amount'
                    , 'total_cost_amount'
                    , 'diagnosis_poa_1'
                    , 'diagnosis_poa_2'
                    , 'diagnosis_poa_3'
                    , 'diagnosis_poa_4'
                    , 'diagnosis_poa_5'
                    , 'diagnosis_poa_6'
                    , 'diagnosis_poa_7'
                    , 'diagnosis_poa_8'
                    , 'diagnosis_poa_9'
                    , 'diagnosis_poa_10'
                    , 'diagnosis_poa_11'
                    , 'diagnosis_poa_12'
                    , 'diagnosis_poa_13'
                    , 'diagnosis_poa_14'
                    , 'diagnosis_poa_15'
                    , 'diagnosis_poa_16'
                    , 'diagnosis_poa_17'
                    , 'diagnosis_poa_18'
                    , 'diagnosis_poa_19'
                    , 'diagnosis_poa_20'
                    , 'diagnosis_poa_21'
                    , 'diagnosis_poa_22'
                    , 'diagnosis_poa_23'
                    , 'diagnosis_poa_24'
                    , 'diagnosis_poa_25'
                    , 'procedure_code_type'
                    , 'procedure_code_1'
                    , 'procedure_code_2'
                    , 'procedure_code_3'
                    , 'procedure_code_4'
                    , 'procedure_code_5'
                    , 'procedure_code_6'
                    , 'procedure_code_7'
                    , 'procedure_code_8'
                    , 'procedure_code_9'
                    , 'procedure_code_10'
                    , 'procedure_code_11'
                    , 'procedure_code_12'
                    , 'procedure_code_13'
                    , 'procedure_code_14'
                    , 'procedure_code_15'
                    , 'procedure_code_16'
                    , 'procedure_code_17'
                    , 'procedure_code_18'
                    , 'procedure_code_19'
                    , 'procedure_code_20'
                    , 'procedure_code_21'
                    , 'procedure_code_22'
                    , 'procedure_code_23'
                    , 'procedure_code_24'
                    , 'procedure_code_25'
                    , 'procedure_date_1'
                    , 'procedure_date_2'
                    , 'procedure_date_3'
                    , 'procedure_date_4'
                    , 'procedure_date_5'
                    , 'procedure_date_6'
                    , 'procedure_date_7'
                    , 'procedure_date_8'
                    , 'procedure_date_9'
                    , 'procedure_date_10'
                    , 'procedure_date_11'
                    , 'procedure_date_12'
                    , 'procedure_date_13'
                    , 'procedure_date_14'
                    , 'procedure_date_15'
                    , 'procedure_date_16'
                    , 'procedure_date_17'
                    , 'procedure_date_18'
                    , 'procedure_date_19'
                    , 'procedure_date_20'
                    , 'procedure_date_21'
                    , 'procedure_date_22'
                    , 'procedure_date_23'
                    , 'procedure_date_24'
                    , 'procedure_date_25'
                    , 'in_network_flag'
                    , 'data_source'
                    , 'file_name'
                    , 'ingest_datetime']
    ) }}
)
, unpivot_procedure as(
        {{ dbt_utils.unpivot(
        relation=ref('medical_claim'),
        cast_to=type_string(),
        exclude=['claim_id', 'procedure_code_type'],
        field_name='procedure_column',
        value_name='procedure_code',
        remove=[ 'claim_line_number'
                , 'claim_type'
                , 'patient_id'
                , 'member_id'
                , 'payer'
                , 'plan'
                , 'claim_start_date'
                , 'claim_end_date'
                , 'claim_line_start_date'
                , 'claim_line_end_date'
                , 'admission_date'
                , 'discharge_date'
                , 'admit_source_code'
                , 'admit_type_code'
                , 'discharge_disposition_code'
                , 'place_of_service_code'
                , 'bill_type_code'
                , 'ms_drg_code'
                , 'apr_drg_code'
                , 'revenue_center_code'
                , 'service_unit_quantity'
                , 'hcpcs_code'
                , 'hcpcs_modifier_1'
                , 'hcpcs_modifier_2'
                , 'hcpcs_modifier_3'
                , 'hcpcs_modifier_4'
                , 'hcpcs_modifier_5'
                , 'rendering_npi'
                , 'rendering_tin'
                , 'billing_npi'
                , 'billing_tin'
                , 'facility_npi'
                , 'paid_date'
                , 'paid_amount'
                , 'allowed_amount'
                , 'charge_amount'
                , 'coinsurance_amount'
                , 'copayment_amount'
                , 'deductible_amount'
                , 'total_cost_amount'
                , 'diagnosis_code_type'
                , 'diagnosis_code_1'
                , 'diagnosis_code_2'
                , 'diagnosis_code_3'
                , 'diagnosis_code_4'
                , 'diagnosis_code_5'
                , 'diagnosis_code_6'
                , 'diagnosis_code_7'
                , 'diagnosis_code_8'
                , 'diagnosis_code_9'
                , 'diagnosis_code_10'
                , 'diagnosis_code_11'
                , 'diagnosis_code_12'
                , 'diagnosis_code_13'
                , 'diagnosis_code_14'
                , 'diagnosis_code_15'
                , 'diagnosis_code_16'
                , 'diagnosis_code_17'
                , 'diagnosis_code_18'
                , 'diagnosis_code_19'
                , 'diagnosis_code_20'
                , 'diagnosis_code_21'
                , 'diagnosis_code_22'
                , 'diagnosis_code_23'
                , 'diagnosis_code_24'
                , 'diagnosis_code_25'
                , 'diagnosis_poa_1'
                , 'diagnosis_poa_2'
                , 'diagnosis_poa_3'
                , 'diagnosis_poa_4'
                , 'diagnosis_poa_5'
                , 'diagnosis_poa_6'
                , 'diagnosis_poa_7'
                , 'diagnosis_poa_8'
                , 'diagnosis_poa_9'
                , 'diagnosis_poa_10'
                , 'diagnosis_poa_11'
                , 'diagnosis_poa_12'
                , 'diagnosis_poa_13'
                , 'diagnosis_poa_14'
                , 'diagnosis_poa_15'
                , 'diagnosis_poa_16'
                , 'diagnosis_poa_17'
                , 'diagnosis_poa_18'
                , 'diagnosis_poa_19'
                , 'diagnosis_poa_20'
                , 'diagnosis_poa_21'
                , 'diagnosis_poa_22'
                , 'diagnosis_poa_23'
                , 'diagnosis_poa_24'
                , 'diagnosis_poa_25'
                , 'procedure_date_1'
                , 'procedure_date_2'
                , 'procedure_date_3'
                , 'procedure_date_4'
                , 'procedure_date_5'
                , 'procedure_date_6'
                , 'procedure_date_7'
                , 'procedure_date_8'
                , 'procedure_date_9'
                , 'procedure_date_10'
                , 'procedure_date_11'
                , 'procedure_date_12'
                , 'procedure_date_13'
                , 'procedure_date_14'
                , 'procedure_date_15'
                , 'procedure_date_16'
                , 'procedure_date_17'
                , 'procedure_date_18'
                , 'procedure_date_19'
                , 'procedure_date_20'
                , 'procedure_date_21'
                , 'procedure_date_22'
                , 'procedure_date_23'
                , 'procedure_date_24'
                , 'procedure_date_25'
                , 'in_network_flag'
                , 'data_source'
                , 'file_name'
                , 'ingest_datetime'
    ]
    ) }}


)
, total_claims as(
    select
        cast(count(claim_id) as integer ) as total_claims
    from {{ ref('medical_claim') }}
)
, claims_with_primary_dx as(
    select
        count(diagnosis_code_1)
    from {{ ref('medical_claim') }}
)

, claims_with_secondary_dx as(
    select
    total_claims
    , cast(secondary_dx_claim_count as integer ) as secondary_dx_claim_count
    , (cast(secondary_dx_claim_count as integer ) / cast(total_claims as integer )) * 100 as percent_claim_with_secondar_dx
    , 'Percent of claims with secondary diagnosis' as data_quality_check
    from
    (
    select
        tc.total_claims
        , cast(count(*) as integer ) as secondary_dx_claim_count
    from unpivot_diagnosis
    cross join total_claims tc
    where diagnosis_column <> 'DIAGNOSIS_CODE_1'
    group by total_claims
    ) x
)
, missing_primary_dx as (
    select
        'missing primary diagnosis' as data_quality_check
        , cast(count(distinct claim_id) as integer ) as missing_primary_dx_count
    from {{ ref('medical_claim') }} m
    where diagnosis_code_1 is null
)
, invalid_primary_dx as(
    select
        data_quality_check
        , count(distinct claim_id) as invalid_primary_dx_count
    from (
    select
        'invalid primary diagnosis' as data_quality_check
        , claim_id
        , diagnosis_code_type
        , diagnosis_column
        , diagnosis_code
        , icd_10_cm
        , icd_9_cm
        , case
            when icd10.icd_10_cm is null and icd9.icd_9_cm is null
                then 1
            else 0
        end as invalid_diagnosis
    from unpivot_diagnosis dx
    left join {{ ref('terminology__icd_10_cm') }} icd10
        on dx.diagnosis_code = icd10.icd_10_cm
    left join {{ ref('terminology__icd_9_cm') }} icd9
        on dx.diagnosis_code = icd9.icd_9_cm
    where diagnosis_column = 'DIAGNOSIS_CODE_1'
    and diagnosis_code is not null
    )x
   where invalid_diagnosis = 1
    group by
        data_quality_check
)
, multiple_primary_dx as(

    select
        'multiple primary diagnosis' as data_quality_check
        , cast(count(*) as integer ) as multiple_primary_dx_count
    from
        (
            select
                claim_id
                , row_number() over (partition by claim_id order by claim_id) as row_nbr
            from unpivot_diagnosis
             where diagnosis_column = 'DIAGNOSIS_CODE_1'
            group by
                claim_id
            )x
    where row_nbr > 1

)
, invalid_secondary_dx as(
    select
        data_quality_check
        , count(*) as invalid_secondary_dx_count
    from (
    select
        'invalid secondary diagnosis' as data_quality_check
        , claim_id
        , case
            when icd10.icd_10_cm is null and icd9.icd_9_cm is null
                then 1
            else 0
        end as invalid_diagnosis
    from unpivot_diagnosis dx
    left join {{ ref('terminology__icd_10_cm') }} icd10
        on dx.diagnosis_code = icd10.icd_10_cm
    left join {{ ref('terminology__icd_9_cm') }} icd9
    on dx.diagnosis_code = icd9.icd_9_cm
    where diagnosis_column <> 'DIAGNOSIS_CODE_1'
    and diagnosis_code is not null
    )x
    where invalid_diagnosis = 1
    group by
        data_quality_check
)

, invalid_procedure as(
    select
        data_quality_check
        , count(*) as invalid_px_count
    from (
    select
        'invalid procedure' as data_quality_check
        , claim_id
        , case
            when icd10.icd_10_pcs is null and icd9.icd_9_pcs is null
                then 1
            else 0
        end as invalid_procedure
    from unpivot_procedure px
    left join {{ ref('terminology__icd_10_pcs') }} icd10
        on px.procedure_code = icd10.icd_10_pcs
    left join {{ ref('terminology__icd_9_pcs') }} icd9
    on px.procedure_code = icd9.icd_9_pcs
    where px.procedure_code is not null
    )x
    where invalid_procedure = 1
    group by
        data_quality_check
)

select *, '{{ var('tuva_last_run')}}' as tuva_last_run from missing_primary_dx
union all
select *, '{{ var('tuva_last_run')}}' as tuva_last_run from invalid_primary_dx
union all
select *, '{{ var('tuva_last_run')}}' as tuva_last_run from multiple_primary_dx
union all
select *, '{{ var('tuva_last_run')}}' as tuva_last_run from invalid_secondary_dx
union all
select data_quality_check, percent_claim_with_secondar_dx, '{{ var('tuva_last_run')}}' as tuva_last_run from claims_with_secondary_dx
union all
select *, '{{ var('tuva_last_run')}}' as tuva_last_run from invalid_procedure
