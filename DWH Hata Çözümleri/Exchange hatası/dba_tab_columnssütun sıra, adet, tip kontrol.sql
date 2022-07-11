SELECT table_name,column_name, data_type, data_length, data_precision, data_scale, nullable, column_id, character_set_name, char_col_decl_length, char_length, char_used, default_on_null, identity_column
  FROM user_tab_columns 
 WHERE 1=1
       AND table_name IN ( 'TBL_CUSTOMER_HIST','TBL_CUSTOMER_HIST_EXC')
       AND column_id IN (
                            SELECT column_id
                              FROM (
                                    (
                                     SELECT data_type, data_length, data_precision, data_scale, nullable, column_id, character_set_name, char_col_decl_length, char_length, char_used, default_on_null, identity_column
                                       FROM user_tab_columns where table_name ='TBL_CUSTOMER_HIST_EXC'
                                     MINUS
                                     SELECT data_type, data_length, data_precision, data_scale, nullable, column_id, character_set_name, char_col_decl_length, char_length, char_used, default_on_null, identity_column
                                       FROM user_tab_columns where table_name='TBL_CUSTOMER_HIST'
                                    )
								    UNION ALL
								    (
                                     SELECT data_type, data_length, data_precision, data_scale, nullable, column_id, character_set_name, char_col_decl_length, char_length, char_used, default_on_null, identity_column
                                       FROM user_tab_columns where table_name ='TBL_CUSTOMER_HIST'
                                     MINUS
                                     SELECT data_type, data_length, data_precision, data_scale, nullable, column_id, character_set_name, char_col_decl_length, char_length, char_used, default_on_null, identity_column
                                       FROM user_tab_columns where table_name='TBL_CUSTOMER_HIST_EXC'
                                    )
                                   )
                          )
ORDER BY column_id;