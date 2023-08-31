{{ config(
     enabled = var('quality_measures_reporting_enabled',var('claims_enabled',var('tuva_marts_enabled',False)))
   )
}}

/*
    Each measure is pivoted into a boolean column by evaluating the
    denominator, numerator, and exclusion flags.
*/
with measures_long as (

        select
          patient_id
        , denominator_flag
        , numerator_flag
        , exclusion_flag
        , measure_id
    from {{ ref('quality_measures_reporting__summary_long') }}

)

, nqf_2372 as (

    select
          patient_id
        , case
            when denominator_flag = 1
            then
                case
                    when exclusion_flag = 1 then null
                    when exclusion_flag = 0  then numerator_flag
            else null
                end
          end as flag
    from measures_long
    where measure_id = 'NQF2372'

)

, joined as (

    select
          measures_long.patient_id
        , nqf_2372.flag as nqf_2372
    from measures_long
         left join nqf_2372
         on measures_long.patient_id = nqf_2372.patient_id

)

, add_data_types as (

    select
          cast(patient_id as {{ dbt.type_string() }}) as patient_id
        , cast(nqf_2372 as integer) as nqf_2372
    from joined

)

select
      patient_id
    , nqf_2372
    , '{{ var('tuva_last_run')}}' as tuva_last_run
from add_data_types