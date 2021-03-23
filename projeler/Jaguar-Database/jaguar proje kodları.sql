DROP TABLE jaguar_modelleri CASCADE CONSTRAINTS;

CREATE TABLE jaguar_modelleri
(
    model_id number(10),
    model_ad varchar2(50 CHAR) NOT NULL,
    CONSTRAINTS pk_model_id PRIMARY KEY (model_id)
);

DROP TABLE kasa_tipi CASCADE CONSTRAINTS;


CREATE TABLE kasa_tipi
(
    kasa_tip_id NUMBER(2),
    kasa_tipi   VARCHAR2(20 CHAR),
    CONSTRAINT pk_kasa_tip_id PRIMARY KEY (kasa_tip_id)
);

DROP TABLE motor_sanziman_secenegi CASCADE CONSTRAINTS;

CREATE TABLE motor_sanziman_secenegi
(
    m_s_id              NUMBER(10),
    kasa_kodu           VARCHAR2(4 CHAR),
    model_id            NUMBER(10),
    motor_hacmi         NUMBER(5),
    yakit_tipi          VARCHAR2(20 CHAR),
    sanziman            VARCHAR2(50 CHAR),
    cekis               VARCHAR2(10 CHAR),
    hp                  NUMBER(4),
    kw                  NUMBER(5,1),
    performans_0_100_sn NUMBER(3,1),
    ort_yakit_tuketimi  NUMBER(5,1),
    uretim_baslangic    NUMBER(4),
    uretim_bitis        NUMBER(4),
    kasa_tip_id         NUMBER(2),
    CONSTRAINT pk_m_s_id PRIMARY KEY (m_s_id),
    CONSTRAINT fk_model_id FOREIGN KEY (model_id) REFERENCES jaguar_modelleri (model_id),
    CONSTRAINT fk_kasa_tip_id FOREIGN KEY (kasa_tip_id) REFERENCES kasa_tipi (kasa_tip_id)
);

DROP TABLE yil;

CREATE TABLE yil
(
    yil number(4)
);

DROP TABLE resim CASCADE CONSTRAINTS;

CREATE TABLE resim
(
    resim_id    NUMBER(10) GENERATED ALWAYS AS IDENTITY,
    resim_path VARCHAR2(200) NOT NULL,
    CONSTRAINTS pk_resim_id PRIMARY KEY (resim_id)
);

DROP TABLE resim_arac;

CREATE TABLE resim_arac
(
    resim_id number(10),
    m_s_id   number(10),
    CONSTRAINTS pk_resim_arac PRIMARY KEY (resim_id,m_s_id),
    CONSTRAINT fk_resim_id FOREIGN KEY (resim_id) REFERENCES resim (resim_id),
    CONSTRAINT fk_m_s_id FOREIGN KEY (m_s_id) REFERENCES motor_sanziman_secenegi (m_s_id)
);


DROP SEQUENCE seq_m_s_id;
CREATE SEQUENCE seq_m_s_id
  MAXVALUE 9999999999
  START WITH 1
  INCREMENT BY 1
  CACHE 20
  NOORDER
  NOCYCLE;
  
   
  
CREATE OR REPLACE FUNCTION fnc_car_hp_to_kw (v_hp IN NUMBER )
RETURN number IS
BEGIN
    return v_hp*0.73549875;
END;

CREATE OR REPLACE TRIGGER trg_calculate_kw
    BEFORE INSERT
    ON motor_sanziman_secenegi
    REFERENCING NEW AS NEW OLD AS OLD 
    FOR EACH ROW
DECLARE
   v_kw NUMBER(5,1);
BEGIN
   IF(:NEW.KW IS NULL OR :NEW.KW=0) THEN
   v_kw := fnc_car_hp_to_kw(:NEW.HP);
   :NEW.KW := v_kw;
   END IF;
END;



--SELECT fnc_car_hp_to_kw(130) FROM dual;

insert into jaguar_modelleri values ( 1,'E-Pace');
insert into jaguar_modelleri values ( 2,'E-Type');
insert into jaguar_modelleri values ( 3,'F-Pace');
insert into jaguar_modelleri values ( 4,'F-Type');
insert into jaguar_modelleri values ( 5,'I-Pace');
insert into jaguar_modelleri values ( 6,'S-Type');
insert into jaguar_modelleri values ( 7,'X-Type');
insert into jaguar_modelleri values ( 8,'XE');
insert into jaguar_modelleri values ( 9,'XF');
insert into jaguar_modelleri values ( 10,'XJ');
insert into jaguar_modelleri values ( 11,'XJ220');
insert into jaguar_modelleri values ( 12,'XJS');
insert into jaguar_modelleri values ( 13,'XK');
commit;

insert into kasa_tipi values ( 1,'Coupe');
insert into kasa_tipi values ( 2,'Hatchback 3 Kapi');
insert into kasa_tipi values ( 3,'Hatchback 5 kapi');
insert into kasa_tipi values ( 4,'Sedan');
insert into kasa_tipi values ( 5,'Station Wagon');
insert into kasa_tipi values ( 6,'Crossover');
insert into kasa_tipi values ( 7,'MPV');
insert into kasa_tipi values ( 8,'Roadster');
insert into kasa_tipi values ( 9,'Cabrio');
insert into kasa_tipi values ( 10,'Hard top');
insert into kasa_tipi values ( 11,'Pickup');
insert into kasa_tipi values ( 12,'SUV');
commit;

--SELECT * FROM jaguar_modelleri

--e-pace
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X540', 1,  1999, 'Dizel',  'MV', 'Ön',   150, null, 10.1, 4.8, 2018, 2020, 12);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X540', 1,  1999, 'Dizel',  'MV', 'AWD',  150, null, 10.7, 5.2, 2018, 2020, 12);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X540', 1,  1999, 'Dizel',  'OV', 'AWD',  150, null, 10.5, 5.6, 2018, 2020, 12);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X540', 1,  1999, 'Dizel',  'MV', 'AWD',  180, null, 9.9,  5.2, 2018, 2020, 12);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X540', 1,  1999, 'Dizel',  'OV', 'AWD',  180, null, 9.4,  5.6, 2018, 2020, 12);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X540', 1,  1999, 'Dizel',  'OV', 'AWD',  240, null, 7.4,  6.2, 2018, 2020, 12);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X540', 1,  1998, 'Benzin', 'OV', 'AWD',  200, null, 8.2,  8.2, 2018, 2020, 12);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X540', 1,  1998, 'Benzin', 'OV', 'AWD',  250, null, 7.0,  7.7, 2018, 2020, 12);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X540', 1,  1998, 'Benzin', 'OV', 'AWD',  300, null, 6.4,  8.0, 2018, 2020, 12);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X540', 1,  1997, 'Benzin', 'OV', 'AWD',  300, null, 6.9,  9.3, 2020, NULL, 12);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X540', 1,  1997, 'Benzin', 'OV', 'AWD',  249, null, 7.5,  9.3, 2020, NULL, 12);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X540', 1,  1997, 'Benzin', 'OV', 'AWD',  200, null, 8.5,  9.3, 2020, NULL, 12);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X540', 1,  1997, 'Dizel',  'OV', 'AWD',  204, null, 8.4,  6.7, 2020, NULL, 12);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X540', 1,  1997, 'Dizel',  'OV', 'AWD',  163, null, 9.8,  6.6, 2020, NULL, 12);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X540', 1,  1997, 'Dizel',  'MV', 'Ön',   163, null, 10.0, 6.4, 2020, NULL, 12);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X540', 1,  1498, 'Hibrit', 'OV', 'AWD',  309, null, 6.5,  2.0, 2020, NULL, 12);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X540', 1,  1498, 'Benzin', 'OV', 'Ön',   160, null, 10.3, 8.2, 2020, NULL, 12);
--f-pace                                    
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  5000, 'Benzin', 'OV', 'AWD',  550, null, 4.3, 11.7, 2018, 2020, 8);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  1999, 'Dizel',  'MV', 'Arka', 163, null, 5.4, 11.7, 2019, 2020, 8);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  1997, 'Benzin', 'OV', 'AWD',  300, null, 6.1, 7.6,  2019, 2020, 8);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  2993, 'Dizel',  'OV', 'AWD',  300, null, 6.4, 6.3,  2019, 2020, 8);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  2995, 'Benzin', 'OV', 'AWD',  380, null, 5.5, 8.9,  2016, 2018, 8);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  2995, 'Benzin', 'OV', 'AWD',  340, null, 5.8, 8.9,  2016, 2017, 8);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  2993, 'Dizel',  'OV', 'AWD',  300, null, 6.2, 6.0,  2015, 2018, 8);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  1997, 'Benzin', 'OV', 'AWD',  250, null, 7.0, 7.6,  2019, 2020, 8);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  1999, 'Dizel',  'OV', 'AWD',  240, null, 7.2, 6.4,  2019, 2020, 8);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  1999, 'Dizel',  'OV', 'AWD',  180, null, 9.0, 5.8,  2019, 2020, 8);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  1999, 'Dizel',  'OV', 'Arka', 180, null, 8.6, 5.6,  2019, 2020, 8);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  1997, 'Benzin', 'OV', 'AWD',  300, null, 6.0, 7.7,  2017, 2018, 8);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  1997, 'Benzin', 'OV', 'AWD',  250, null, 6.8, 7.4,  2017, 2018, 8);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  1997, 'Benzin', 'OV', 'Arka', 250, null, 6.8, 7.1,  2017, 2018, 8);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  1999, 'Dizel',  'OV', 'AWD',  240, null, 7.2, 5.8,  2017, 2018, 8);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  1999, 'Dizel',  'OV', 'AWD',  180, null, 8.7, 5.3,  2015, 2018, 8);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  1999, 'Dizel',  'MV', 'AWD',  180, null, 8.7, 5.2,  2017, 2017, 8);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  1999, 'Dizel',  'OV', 'Arka', 180, null, 8.5, 5.1,  2017, 2018, 8);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  1999, 'Dizel',  'MV', 'Arka', 180, null, 8.9, 4.9,  2015, 2017, 8);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X761', 3,  1999, 'Dizel',  'MV', 'Arka', 163, null, 10.2, 4.8, 2017, 2018, 8);
--f type                                    
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'MV', 'Arka', 340, null, 5.7, 9.8,  2013, 2017, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'OV', 'Arka', 340, null, 5.3, 8.4,  2013, 2017, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'MV', 'Arka', 495, null, 4.3, 11.1, 2013, 2017, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'Arka', 550, null, 4.2, 10.7, 2014, 2017, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'AWD',  550, null, 4.1, 11.3, 2014, 2017, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'MV', 'Arka', 380, null, 5.5, 11.3, 2013, 2017, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'OV', 'Arka', 380, null, 4.9, 8.6,  2013, 2017, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'OV', 'AWD',  380, null, 5.1, 8.1,  2013, 2017, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'AWD',  575, null, 3.7, 11.3, 2016, 2017, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'AWD',  575, null, 3.7, 11.3, 2016, 2017, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'OV', 'AWD',  380, null, 5.1, 8.1,  2014, 2017, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'OV', 'Arka', 380, null, 4.9, 8.8,  2014, 2017, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'MV', 'Arka', 380, null, 5.5, 9.8,  2014, 2017, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'AWD',  550, null, 4.1, 11.3, 2014, 2017, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'Arka', 550, null, 4.2, 10.7, 2014, 2017, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'OV', 'Arka', 340, null, 5.3, 8.4,  2014, 2017, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'MV', 'Arka', 340, null, 5.7, 9.8,  2014, 2017, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'AWD',  575, null, 3.7, 10.9, 2017, 2020, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'AWD',  550, null, 4.1, 10.9, 2019, 2020, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'MV', 'AWD',  550, null, 4.1, 11.3, 2017, 2018, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'Arka', 550, null, 4.2, 10.7, 2017, 2018, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'OV', 'AWD',  380, null, 5.1, 10.2, 2019, 2020, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'OV', 'Arka', 380, null, 4.9, 9.8,  2019, 2020, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'MV', 'Arka', 380, null, 5.5, 10.6, 2019, 2020, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'OV', 'Arka', 340, null, 5.3, 9.8,  2019, 2020, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'MV', 'Arka', 340, null, 5.7, 10.3, 2019, 2020, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  1997, 'Benzin', 'OV', 'Arka', 300, null, 5.7, 7.9,  2019, 2020, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'MV', 'AWD',  400, null, 5.1, 8.9,  2017, 2018, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'OV', 'Arka', 400, null, 4.9, 8.6,  2017, 2018, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'MV', 'AWD',  380, null, 5.1, 8.9,  2017, 2018, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'OV', 'Arka', 380, null, 4.9, 8.6,  2017, 2018, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'MV', 'Arka', 380, null, 5.5, 9.8,  2017, 2018, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'OV', 'Arka', 340, null, 5.3, 8.4,  2017, 2018, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'MV', 'Arka', 340, null, 5.7, 9.8,  2017, 2018, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  1997, 'Benzin', 'OV', 'Arka', 300, null, 5.7, 7.2,  2017, 2018, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'AWD',  575, null, 3.7, 10.9, 2017, 2020, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'AWD',  575, null, 3.7, 10.9, 2017, 2020, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'AWD',  550, null, 4.1, 10.9, 2019, 2020, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'AWD',  550, null, 4.1, 11.3, 2017, 2018, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'Arka', 550, null, 4.2, 10.7, 2017, 2018, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'OV', 'AWD',  380, null, 5.1, 10.2, 2019, 2020, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'OV', 'Arka', 380, null, 4.9, 9.8,  2019, 2020, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'MV', 'Arka', 380, null, 5.5, 10.6, 2019, 2020, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'OV', 'Arka', 340, null, 5.3, 9.8,  2019, 2020, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'MV', 'Arka', 340, null, 5.7, 10.3, 2019, 2020, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  1997, 'Benzin', 'OV', 'Arka', 300, null, 5.7, 7.9,  2019, 2020, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'MV', 'AWD',  400, null, 5.1, 8.9,  2017, 2018, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'OV', 'Arka', 400, null, 4.9, 8.6,  2017, 2018, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'MV', 'AWD',  380, null, 5.1, 8.9,  2017, 2018, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'OV', 'Arka', 380, null, 4.9, 8.6,  2017, 2018, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'MV', 'Arka', 380, null, 5.5, 9.8,  2017, 2018, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'OV', 'Arka', 340, null, 5.3, 8.4,  2017, 2018, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  2995, 'Benzin', 'MV', 'Arka', 340, null, 5.7, 9.8,  2017, 2018, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  1997, 'Benzin', 'OV', 'Arka', 300, null, 5.7, 7.2,  2017, 2018, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'AWD',  575, null, 3.7, 11.0, 2019, null, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'Arka', 450, null, 4.6, 10.6, 2019, null, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'AWD',  450, null, 4.6, 11.0, 2019, null, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  1997, 'Benzin', 'OV', 'Arka', 300, null, 5.7, 8.1,  2019, null, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'AWD',  575, null, 3.7, 11.0, 2019, null, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'Arka', 450, null, 4.6, 10.6, 2019, null, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  5000, 'Benzin', 'OV', 'AWD',  450, null, 4.6, 11.0, 2019, null, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X152', 4,  1997, 'Benzin', 'OV', 'Arka', 300, null, 5.7, 8.1,  2019, null, 1);
--i-pace                                    
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X590', 5,  90, 'Elektrik', 'OV', 'AWD',  400, null, 4.8, 23.6, 2018, null, 12);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X590', 5,  90, 'Elektrik', 'OV', 'AWD',  320, null, 6.4, 23.6, 2020, null, 12);
--s-type                                    
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X200', 6,  4196, 'Benzin', 'OV', 'Arka', 395, null, 5.6, 12.5, 2001, 2007, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X200', 6,  4196, 'Benzin', 'OV', 'Arka', 298, null, 6.5, 12.3, 2001, 2007, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X200', 6,  2967, 'Benzin', 'OV', 'Arka', 276, null, 7.1, 12.5, 1998, 2002, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X200', 6,  2967, 'Benzin', 'OV', 'Arka', 238, null, 7.9, 11.2, 1998, 2007, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X200', 6,  2967, 'Benzin', 'MV', 'Arka', 238, null, 7.6, 11.2, 1998, 2007, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X200', 6,  2720, 'Dizel',  'OV', 'Arka', 207, null, 8.6, 8.5,  2004, 2007, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X200', 6,  2720, 'Dizel',  'MV', 'Arka', 207, null, 7.7, 11.2, 2004, 2007, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X200', 6,  2497, 'Benzin', 'OV', 'Arka', 200, null, 9.9, 10.3, 2001, 2007, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X200', 6,  2497, 'Benzin', 'MV', 'Arka', 200, null, 8.6, 9.5,  2001, 2007, 4);
--x-type                                    
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X400', 7,  2968, 'Benzin', 'OV', 'AWD',  231, null, 7.5,  10.5, 2001, 2009, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X400', 7,  2968, 'Benzin', 'MV', 'AWD',  231, null, 7.0,  10.3, 2001, 2009, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X400', 7,  2495, 'Benzin', 'OV', 'AWD',  231, null, 8.9,  10.3, 2001, 2009, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X400', 7,  2495, 'Benzin', 'MV', 'AWD',  231, null, 8.3,  9.6,  2001, 2009, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X400', 7,  2099, 'Benzin', 'OV', 'Ön',   156, null, 10.8, 10.0, 2001, 2009, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X400', 7,  2099, 'Benzin', 'MV', 'Ön',   156, null, 9.4,  9.2,  2001, 2009, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X400', 7,  2198, 'Dizel',  'OV', 'Ön',   155, null, 8.9,  6.5,  2005, 2009, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X400', 7,  1998, 'Dizel',  'MV', 'Ön',   130, null, 9.9,  5.6,  2003, 2009, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X400', 7,  2968, 'Benzin', 'MV', 'Ön',   231, null, 8.5,  11.3, 2003, 2009, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X400', 7,  2495, 'Benzin', 'MV', 'Ön',   196, null, 7.2,  10.5, 2003, 2009, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X400', 7,  2099, 'Benzin', 'MV', 'Ön',   156, null, 9.6,  10.1, 2003, 2009, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X400', 7,  2198, 'Dizel',  'MV', 'Ön',   155, null, 9.3,  6.6,  2005, 2009, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X400', 7,  1998, 'Dizel',  'MV', 'Ön',   155, null, 10.2, 6.2,  2003, 2009, 5);
--xe                                        
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  5000, 'Benzin', 'OV', 'AWD',  600, null, 3.7,  11.0, 2017, 2017, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  2995, 'Benzin', 'OV', 'Arka', 380, null, 5.0,  8.1,  2017, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  2995, 'Benzin', 'OV', 'Arka', 340, null, 5.1,  8.1,  2015, 2017, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1999, 'Dizel',  'OV', 'AWD',  240, null, 6.1,  5.2,  2017, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1999, 'Dizel',  'OV', 'AWD',  180, null, 7.9,  5.2,  2016, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1999, 'Dizel',  'OV', 'Arka', 180, null, 7.8,  5.2,  2015, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1999, 'Dizel',  'MV', 'Arka', 180, null, 7.8,  5.0,  2015, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1999, 'Dizel',  'OV', 'Arka', 163, null, 8.2,  4.2,  2015, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1999, 'Dizel',  'MV', 'Arka', 163, null, 8.4,  3.8,  2015, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1997, 'Benzin', 'OV', 'AWD',  300, null, 5.5,  6.9,  2017, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1997, 'Benzin', 'OV', 'Arka', 300, null, 5.7,  6.7,  2017, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1997, 'Benzin', 'OV', 'AWD',  250, null, 5.7,  6.8,  2017, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1997, 'Benzin', 'OV', 'Arka', 250, null, 5.3,  6.3,  2017, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1997, 'Benzin', 'OV', 'Arka', 240, null, 6.9,  7.5,  2015, 2017, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1997, 'Benzin', 'OV', 'Arka', 200, null, 7.7,  7.5,  2015, 2017, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1997, 'Benzin', 'OV', 'AWD',  300, null, 5.7,  7.3,  2019, 2020, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1997, 'Benzin', 'OV', 'Arka', 300, null, 5.9,  6.9,  2019, 2020, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1997, 'Benzin', 'OV', 'AWD',  250, null, 6.5,  7.3,  2019, 2020, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1997, 'Benzin', 'OV', 'Arka', 250, null, 6.5,  7.0,  2019, 2020, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1999, 'Dizel',  'OV', 'AWD',  180, null, 8.4,  5.2,  2019, 2020, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1999, 'Dizel',  'OV', 'Arka', 180, null, 8.1,  4.9,  2019, 2020, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1997, 'Benzin', 'OV', 'AWD',  300, null, 5.9,  9.1,  2020, null, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1997, 'Benzin', 'OV', 'AWD',  250, null, 6.8,  7.7,  2020, null, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1997, 'Benzin', 'OV', 'Arka', 250, null, 6.7,  8.6,  2020, null, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1997, 'Dizel',  'OV', 'AWD',  204, null, 7.5,  5.3,  2020, null, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X760', 8,  1997, 'Dizel',  'OV', 'Arka', 204, null, 7.3,  5.1,  2020, null, 4);
--XF                                        
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  5000, 'Benzin', 'OV', 'Arka', 510, null, 4.9,  12.5, 2009, 2011, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  5000, 'Benzin', 'OV', 'Arka', 385, null, 5.7,  11.1, 2009, 2011, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  4196, 'Benzin', 'OV', 'Arka', 416, null, 5.4,  12.6, 2007, 2011, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  4196, 'Benzin', 'OV', 'Arka', 298, null, 6.5,  11.1, 2007, 2011, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  2967, 'Benzin', 'OV', 'Arka', 238, null, 8.3,  10.5, 2007, 2011, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  2720, 'Benzin', 'OV', 'Arka', 207, null, 8.2,  7.5,  2007, 2011, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  5000, 'Benzin', 'OV', 'Arka', 550, null, 4.6,  11.6, 2012, 2015, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  5000, 'Benzin', 'OV', 'Arka', 510, null, 4.9,  11.6, 2011, 2015, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  5000, 'Benzin', 'OV', 'Arka', 385, null, 5.7,  11.1, 2011, 2015, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  2993, 'Dizel',  'OV', 'Arka', 275, null, 6.4,  6.0,  2011, 2015, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  2993, 'Dizel',  'OV', 'Arka', 240, null, 7.1,  6.0,  2011, 2015, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  2995, 'Benzin', 'OV', 'AWD',  340, null, 4.6,  9.8,  2012, 2015, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  2995, 'Benzin', 'OV', 'Arka', 340, null, 5.9,  9.6,  2012, 2015, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  2967, 'Benzin', 'OV', 'Arka', 238, null, 8.3,  10.5, 2011, 2015, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  2179, 'Dizel',  'OV', 'Arka', 200, null, 8.5,  5.1,  2012, 2015, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  2179, 'Dizel',  'OV', 'Arka', 190, null, 8.5,  5.4,  2011, 2015, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  2179, 'Dizel',  'OV', 'Arka', 163, null, 10.5, 5.0,  2012, 2015, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  1999, 'Dizel',  'OV', 'Arka', 240, null, 7.9,  8.1,  2012, 2015, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  2993, 'Dizel',  'OV', 'Arka', 275, null, 6.6,  6.1,  2012, 2015, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  2993, 'Dizel',  'OV', 'Arka', 240, null, 7.1,  6.1,  2012, 2015, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  2179, 'Dizel',  'OV', 'Arka', 200, null, 8.8,  5.1,  2012, 2015, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X250', 9,  2179, 'Dizel',  'OV', 'Arka', 163, null, 10.9, 5.1,  2012, 2015, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  2995, 'Benzin', 'OV', 'AWD',  380, null, 5.5,  8.6,  2015, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  2995, 'Benzin', 'OV', 'Arka', 380, null, 5.3,  8.3,  2015, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'OV', 'Arka', 163, null, 9.1,  5.1,  2019, 2020, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'MV', 'Arka', 163, null, 9.8,  4.7,  2019, 2020, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1997, 'Benzin', 'OV', 'AWD',  300, null, 5.9,  7.5,  2019, 2020, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  2993, 'Dizel',  'OV', 'AWD',  300, null, 6.4,  5.9,  2019, 2020, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  2993, 'Dizel',  'OV', 'Arka', 300, null, 6.2,  5.5,  2015, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  2995, 'Benzin', 'OV', 'AWD',  340, null, 5.4,  8.6,  2015, 2017, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  2995, 'Benzin', 'OV', 'Arka', 340, null, 5.4,  8.3,  2015, 2017, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1997, 'Benzin', 'OV', 'Arka', 250, null, 6.7,  7.2,  2019, 2020, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'OV', 'AWD',  240, null, 6.9,  5.6,  2019, 2020, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'OV', 'AWD',  180, null, 8.5,  5.5,  2019, 2020, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'OV', 'Arka', 180, null, 8.4,  5.1,  2019, 2020, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'MV', 'Arka', 180, null, 9.2,  4.8,  2019, 2020, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'OV', 'AWD',  240, null, 6.5,  5.5,  2017, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'OV', 'Arka', 240, null, 6.5,  5.3,  2017, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'OV', 'AWD',  180, null, 8.4,  4.9,  2015, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'OV', 'Arka', 180, null, 8.1,  4.3,  2015, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'MV', 'Arka', 180, null, 8.0,  4.3,  2015, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'OV', 'Arka', 163, null, 8.7,  4.1,  2015, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'MV', 'Arka', 163, null, 8.7,  4.0,  2015, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1997, 'Benzin', 'OV', 'AWD',  300, null, 5.8,  7.2,  2017, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1997, 'Benzin', 'OV', 'AWD',  250, null, 6.6,  6.9,  2017, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1997, 'Benzin', 'OV', 'Arka', 250, null, 6.6,  6.8,  2017, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1997, 'Benzin', 'OV', 'Arka', 200, null, 7.5,  6.8,  2017, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'OV', 'Arka', 163, null, 9.3,  5.3,  2019, 2020, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'MV', 'Arka', 163, null, 10.0, 5.1,  2019, 2020, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1997, 'Benzin', 'OV', 'AWD',  300, null, 6.0,  7.7,  2019, 2020, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  2993, 'Dizel',  'OV', 'AWD',  300, null, 6.6,  6.1,  2019, 2020, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  2993, 'Dizel',  'OV', 'Arka', 300, null, 6.6,  5.7,  2015, 2018, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  2995, 'Benzin', 'OV', 'AWD',  380, null, 5.5,  8.6,  2015, 2017, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1997, 'Benzin', 'OV', 'Arka', 250, null, 6.9,  7.5,  2019, 2020, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'OV', 'AWD',  240, null, 7.0,  5.9,  2019, 2020, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'OV', 'AWD',  180, null, 8.6,  5.6,  2019, 2020, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'OV', 'Arka', 180, null, 8.5,  5.3,  2019, 2020, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'OV', 'AWD',  240, null, 6.7,  5.8,  2015, 2018, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'OV', 'AWD',  180, null, 8.9,  5.0,  2015, 2018, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'OV', 'Arka', 180, null, 8.8,  4.8,  2015, 2018, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'OV', 'Arka', 163, null, 9.4,  4.5,  2015, 2018, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1999, 'Dizel',  'MV', 'Arka', 163, null, 9.3,  4.5,  2015, 2018, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1997, 'Benzin', 'OV', 'AWD',  250, null, 7.1,  6.8,  2015, 2018, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1997, 'Benzin', 'OV', 'Arka', 250, null, 7.1,  6.8,  2015, 2018, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1997, 'Benzin', 'OV', 'AWD',  300, null, 6.1,  8.6,  2020, null, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1997, 'Benzin', 'OV', 'AWD',  250, null, 7.0,  8.6,  2020, null, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1997, 'Benzin', 'OV', 'Arka', 250, null, 6.9,  8.5,  2020, null, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1997, 'Dizel',  'OV', 'AWD',  204, null, 7.8,  5.5,  2020, null, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1997, 'Dizel',  'OV', 'Arka', 204, null, 7.6,  5.3,  2020, null, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1997, 'Benzin', 'OV', 'AWD',  300, null, 6.2,  9.3,  2020, null, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1997, 'Benzin', 'OV', 'Arka', 250, null, 7.1,  8.7,  2020, null, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1997, 'Dizel',  'OV', 'AWD',  204, null, 8.0,  5.9,  2020, null, 5);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X260', 9,  1997, 'Dizel',  'OV', 'Arka', 204, null, 7.8,  5.5,  2020, null, 5);
--xj
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X351', 10, 5000, 'Benzin', 'OV', 'Arka', 575, null, 4.4,  11.1, 2017, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X351', 10, 5000, 'Benzin', 'OV', 'Arka', 550, null, 4.6,  11.1, 2015, 2017, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X351', 10, 5000, 'Benzin', 'OV', 'Arka', 510, null, 4.9,  11.1, 2015, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X351', 10, 5000, 'Benzin', 'OV', 'Arka', 470, null, 5.2,  11.1, 2015, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X351', 10, 2993, 'Dizel',  'OV', 'Arka', 300, null, 6.2,  5.7,  2015, 2019, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X351', 10, 2995, 'Benzin', 'OV', 'AWD',  340, null, 6.4,  9.8,  2015, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X351', 10, 2995, 'Benzin', 'OV', 'Arka', 340, null, 5.9,  9.1,  2015, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X351', 10, 1999, 'Benzin', 'OV', 'Arka', 240, null, 7.9,  8.4,  2015, 2018, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X351', 10, 5000, 'Benzin', 'OV', 'Arka', 550, null, 4.6,  11.6, 2014, 2015, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X351', 10, 5000, 'Benzin', 'OV', 'Arka', 510, null, 4.9,  12.1, 2009, 2012, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X351', 10, 5000, 'Benzin', 'OV', 'Arka', 470, null, 5.2,  12.1, 2009, 2012, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X351', 10, 5000, 'Benzin', 'OV', 'Arka', 385, null, 5.7,  11.4, 2009, 2012, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X351', 10, 2993, 'Dizel',  'OV', 'Arka', 275, null, 6.4,  6.1,  2012, 2015, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X351', 10, 2995, 'Benzin', 'OV', 'AWD',  340, null, 6.4,  9.9,  2014, 2015, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X351', 10, 2995, 'Benzin', 'OV', 'Arka', 300, null, 5.9,  9.6,  2012, 2015, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X351', 10, 2993, 'Dizel',  'OV', 'Arka', 275, null, 6.4,  7.0,  2009, 2012, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X351', 10, 1999, 'Benzin', 'OV', 'Arka', 240, null, 7.5,  8.5,  2012, 2015, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X358', 10, 4196, 'Benzin', 'OV', 'Arka', 395, null, 5.3,  12.1, 2007, 2009, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X358', 10, 4196, 'Benzin', 'OV', 'Arka', 298, null, 6.6,  11.4, 2007, 2009, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X358', 10, 3555, 'Benzin', 'OV', 'Arka', 258, null, 7.6,  10.7, 2007, 2009, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X358', 10, 2967, 'Benzin', 'OV', 'Arka', 238, null, 8.1,  10.5, 2007, 2009, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X358', 10, 2720, 'Dizel',  'OV', 'Arka', 207, null, 8.2,  8.1,  2007, 2009, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X350', 10, 4196, 'Benzin', 'OV', 'Arka', 400, null, 5.3,  12.3, 2003, 2006, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X350', 10, 4196, 'Benzin', 'OV', 'Arka', 300, null, 6.6,  10.9, 2003, 2006, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X350', 10, 3555, 'Benzin', 'OV', 'Arka', 258, null, 7.6,  10.7, 2003, 2006, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X350', 10, 2967, 'Benzin', 'OV', 'Arka', 238, null, 8.1,  10.5, 2003, 2006, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X350', 10, 2722, 'Dizel',  'OV', 'Arka', 207, null, 8.2,  8.1,  2006, 2006, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X308', 10, 3996, 'Benzin', 'OV', 'Arka', 363, null, 5.6,  12.6, 1997, 2003, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X308', 10, 3996, 'Benzin', 'OV', 'Arka', 284, null, 7.3,  12.0, 1997, 2003, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X308', 10, 3248, 'Benzin', 'OV', 'Arka', 237, null, 8.5,  12.1, 1997, 2003, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X300', 10, 3980, 'Benzin', 'OV', 'Arka', 320, null, 6.3,  12.5, 1994, 1997, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X300', 10, 3980, 'Benzin', 'MV', 'Arka', 241, null, 7.4,  11.8, 1994, 1997, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X300', 10, 3980, 'Benzin', 'OV', 'Arka', 241, null, 8.2,  11.0, 1994, 1997, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X300', 10, 3239, 'Benzin', 'MV', 'Arka', 211, null, 8.4,  11.2, 1994, 1997, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X300', 10, 3239, 'Benzin', 'OV', 'Arka', 211, null, 8.4,  11.2, 1994, 1997, 4);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X300', 10, 5993, 'Benzin', 'OV', 'Arka', 211, null, 7.2,  15.7, 1994, 1997, 4);
--xj220
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, null,   11, 3498, 'Benzin', 'MV', 'Arka', 250, null, 3.8,  9.0,  1992, 1994, 1);
--xjs                                   
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, null,   12, 5994, 'Benzin', 'OV', 'Arka', 318, null, 7.4,  13.0,  1991, 1994, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, null,   12, 5993, 'Benzin', 'OV', 'Arka', 302, null, 6.8,  14.9,  1993, 1996, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, null,   12, 5343, 'Benzin', 'OV', 'Arka', 275, null, 8.2,  13.4,  1991, 1994, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, null,   12, 3980, 'Benzin', 'OV', 'Arka', 233, null, 7.7,  10.7,  1994, 1996, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, null,   12, 3980, 'Benzin', 'MV', 'Arka', 233, null, 7.7,  10.7,  1994, 1996, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, null,   12, 3980, 'Benzin', 'MV', 'Arka', 226, null, 7.5,   9.9,  1990, 1994, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, null,   12, 5994, 'Benzin', 'OV', 'Arka', 318, null, 7.4,  13.0,  1990, 1994, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, null,   12, 5993, 'Benzin', 'OV', 'Arka', 302, null, 7.2,  14.9,  1993, 1996, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, null,   12, 5343, 'Benzin', 'OV', 'Arka', 275, null, 8.1,  12.9,  1990, 1994, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, null,   12, 3980, 'Benzin', 'OV', 'Arka', 233, null, 8.9,  10.7,  1994, 1996, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, null,   12, 3980, 'Benzin', 'MV', 'Arka', 233, null, 8.9,  10.7,  1994, 1996, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, null,   12, 3980, 'Benzin', 'MV', 'Arka', 226, null, 8.2,   9.9,  1990, 1994, 9);
--xk
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X100', 13, 4196, 'Benzin', 'OV', 'Arka', 395, null, 5.4,  12.4,  2002, 2005, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X100', 13, 3996, 'Benzin', 'OV', 'Arka', 363, null, 5.4,  12.6,  1998, 2002, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X100', 13, 4196, 'Benzin', 'OV', 'Arka', 298, null, 6.4,  11.3,  2002, 2005, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X100', 13, 3996, 'Benzin', 'OV', 'Arka', 284, null, 6.7,  11.8,  1996, 2002, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X100', 13, 4196, 'Benzin', 'OV', 'Arka', 395, null, 5.6,  12.5,  2002, 2005, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X100', 13, 3996, 'Benzin', 'OV', 'Arka', 363, null, 5.6,  12.7,  1998, 2002, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X100', 13, 4196, 'Benzin', 'OV', 'Arka', 298, null, 6.6,  11.4,  2002, 2005, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X100', 13, 3996, 'Benzin', 'OV', 'Arka', 284, null, 6.7,  11.8,  1996, 2002, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X150', 13, 4196, 'Benzin', 'OV', 'Arka', 416, null, 5.2,  12.3,  2006, 2009, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X150', 13, 4196, 'Benzin', 'OV', 'Arka', 298, null, 6.2,  11.3,  2006, 2009, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X150', 13, 4196, 'Benzin', 'OV', 'Arka', 416, null, 5.3,  12.3,  2006, 2009, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X150', 13, 4196, 'Benzin', 'OV', 'Arka', 298, null, 6.3,  11.3,  2006, 2009, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X150', 13, 5000, 'Benzin', 'OV', 'Arka', 510, null, 4.8,  12.3,  2009, 2011, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X150', 13, 5000, 'Benzin', 'OV', 'Arka', 385, null, 5.5,  11.2,  2009, 2011, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X150', 13, 5000, 'Benzin', 'OV', 'Arka', 510, null, 4.8,  12.3,  2009, 2011, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X150', 13, 5000, 'Benzin', 'OV', 'Arka', 385, null, 5.6,  11.2,  2009, 2011, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X150', 13, 5000, 'Benzin', 'OV', 'Arka', 550, null, 4.4,  12.3,  2011, 2014, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X150', 13, 5000, 'Benzin', 'OV', 'Arka', 510, null, 4.8,  12.3,  2011, 2014, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X150', 13, 5000, 'Benzin', 'OV', 'Arka', 385, null, 5.5,  11.2,  2011, 2014, 1);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X150', 13, 5000, 'Benzin', 'OV', 'Arka', 550, null, 4.4,  12.3,  2011, 2014, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X150', 13, 5000, 'Benzin', 'OV', 'Arka', 510, null, 4.8,  12.3,  2011, 2014, 9);
INSERT INTO motor_sanziman_secenegi VALUES ( seq_m_s_id.NEXTVAL, 'X150', 13, 5000, 'Benzin', 'OV', 'Arka', 385, null, 5.6,  11.2,  2011, 2014, 9);
COMMIT;

INSERT INTO yil
SELECT 1989 + LEVEL as yil
  FROM dual
       CONNECT BY LEVEL <= 32;
COMMIT;


INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1990-1994-XJS-Cabrio.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1992-1994-xj220-1.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1992-1994-xj220-2.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1992-1994-xj220-3.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1994-1996-XJS-4.0-233hp-Cabrio-1.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1994-1996-XJS-4.0-233hp-Cabrio-2.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1994-1997-XJ-1.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1994-1997-XJ-2.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1994-1997-XJ-3.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1994-1997-XJ-4.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1994-1997-XJ-5.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1997-2003-XJ-1.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1997-2003-XJ-2.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1997-2003-XJ-4.0-363hp-Otomatik.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1998-2002-XK-Coupe.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1998-2007-s-type-1.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1998-2007-s-type-2.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1998-2007-s-type-3.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1998-2007-s-type-4.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2003-2005-XJ-4.2-400hp-Otomatik.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2006-2008-XK-4.2-416hp-Otomatik-Coupe.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2006-2008-XK-4.2-416hp-Otomatik-Coupe-2.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2009-2012-xj-1.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2009-2012-xj-2.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2009-2012-xj-3.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2009-2014-XK-Cabrio-1.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2009-2014-XK-Cabrio-2.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2009-2014-XK-Coupe.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2009-2015-XF-1.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2009-2015-XF-2-scaled.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2013-2017-F-Type-Cabrio.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2015-2018-XE.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2016-2021-F-Type-5.0-575hp-AWD-Otomatik-Cabrio-3.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2016-2021-F-Type-5.0-575hp-AWD-Otomatik-Cabrio-2-1.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2016-2021-F-Type-5.0-575hp-AWD-Otomatik-Cabrio-1-1.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2020-2021-e-pace.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/Jaguar-X-Type-5-scaled.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/Jaguar-X-Type-1-scaled.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/Jaguar-X-Type-2-scaled.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/Jaguar-X-Type-3-scaled.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/Jaguar-X-Type-4-scaled.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2015-2021-XF-1.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2015-2021-XF-2.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1990-1996-jaguar-xjs-coupe-1.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/1990-1996-jaguar-xjs-coupe-2-e1616360024546.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2003-2005-XJ-4.2-400hp-Otomatik-2.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2003-2005-XJ-4.2-400hp-Otomatik-3.jpg');
INSERT INTO resim (resim_path) VALUES ('http://www.ilterismutlu.com/wp-content/uploads/2021/03/2009-2014-XK-Coupe-2.jpg');
COMMIT;








--drop table resim


--truncate table resim_Arac

INSERT INTO resim_arac VALUES (1,266);
INSERT INTO resim_arac VALUES (1,268);
INSERT INTO resim_arac VALUES (1,271);
--
INSERT INTO resim_arac VALUES (7, 253);
INSERT INTO resim_arac VALUES (8, 253);
INSERT INTO resim_arac VALUES (9, 253);
INSERT INTO resim_arac VALUES (10,253);
INSERT INTO resim_arac VALUES (11,253);
INSERT INTO resim_arac VALUES (7, 254);
INSERT INTO resim_arac VALUES (8, 254);
INSERT INTO resim_arac VALUES (9, 254);
INSERT INTO resim_arac VALUES (10,254);
INSERT INTO resim_arac VALUES (11,254);
INSERT INTO resim_arac VALUES (7, 255);
INSERT INTO resim_arac VALUES (8, 255);
INSERT INTO resim_arac VALUES (9, 255);
INSERT INTO resim_arac VALUES (10,255);
INSERT INTO resim_arac VALUES (11,255);
INSERT INTO resim_arac VALUES (7, 256);
INSERT INTO resim_arac VALUES (8, 256);
INSERT INTO resim_arac VALUES (9, 256);
INSERT INTO resim_arac VALUES (10,256);
INSERT INTO resim_arac VALUES (11,256);
INSERT INTO resim_arac VALUES (7, 257);
INSERT INTO resim_arac VALUES (8, 257);
INSERT INTO resim_arac VALUES (9, 257);
INSERT INTO resim_arac VALUES (10,257);
INSERT INTO resim_arac VALUES (11,257);
INSERT INTO resim_arac VALUES (7, 258);
INSERT INTO resim_arac VALUES (8, 258);
INSERT INTO resim_arac VALUES (9, 258);
INSERT INTO resim_arac VALUES (10,258);
INSERT INTO resim_arac VALUES (11,258);
--
INSERT INTO resim_arac VALUES (14,250);
--
INSERT INTO resim_arac VALUES (12,251);
INSERT INTO resim_arac VALUES (13,251);
INSERT INTO resim_arac VALUES (12,252);
INSERT INTO resim_arac VALUES (13,252);
--
INSERT INTO resim_arac VALUES (16,102);
INSERT INTO resim_arac VALUES (17,102);
INSERT INTO resim_arac VALUES (18,102);
INSERT INTO resim_arac VALUES (19,102);
INSERT INTO resim_arac VALUES (16,103);
INSERT INTO resim_arac VALUES (17,103);
INSERT INTO resim_arac VALUES (18,103);
INSERT INTO resim_arac VALUES (19,103);
INSERT INTO resim_arac VALUES (16,104);
INSERT INTO resim_arac VALUES (17,104);
INSERT INTO resim_arac VALUES (18,104);
INSERT INTO resim_arac VALUES (19,104);
INSERT INTO resim_arac VALUES (16,105);
INSERT INTO resim_arac VALUES (17,105);
INSERT INTO resim_arac VALUES (18,105);
INSERT INTO resim_arac VALUES (19,105);
INSERT INTO resim_arac VALUES (16,106);
INSERT INTO resim_arac VALUES (17,106);
INSERT INTO resim_arac VALUES (18,106);
INSERT INTO resim_arac VALUES (19,106);
INSERT INTO resim_arac VALUES (16,107);
INSERT INTO resim_arac VALUES (17,107);
INSERT INTO resim_arac VALUES (18,107);
INSERT INTO resim_arac VALUES (19,107);
INSERT INTO resim_arac VALUES (16,108);
INSERT INTO resim_arac VALUES (17,108);
INSERT INTO resim_arac VALUES (18,108);
INSERT INTO resim_arac VALUES (19,108);
INSERT INTO resim_arac VALUES (16,109);
INSERT INTO resim_arac VALUES (17,109);
INSERT INTO resim_arac VALUES (18,109);
INSERT INTO resim_arac VALUES (19,109);
INSERT INTO resim_arac VALUES (16,110);
INSERT INTO resim_arac VALUES (17,110);
INSERT INTO resim_arac VALUES (18,110);
INSERT INTO resim_arac VALUES (19,110);
--
INSERT INTO resim_arac VALUES (2,259);
INSERT INTO resim_arac VALUES (3,259);
INSERT INTO resim_arac VALUES (4,259);
--
INSERT INTO resim_arac VALUES (5,269);
INSERT INTO resim_arac VALUES (6,269);
INSERT INTO resim_arac VALUES (5,270);
INSERT INTO resim_arac VALUES (6,270);
--
INSERT INTO resim_arac VALUES (38,111);
INSERT INTO resim_arac VALUES (39,111);
INSERT INTO resim_arac VALUES (40,111);
INSERT INTO resim_arac VALUES (41,111);
INSERT INTO resim_arac VALUES (37,111);
INSERT INTO resim_arac VALUES (38,112);
INSERT INTO resim_arac VALUES (39,112);
INSERT INTO resim_arac VALUES (40,112);
INSERT INTO resim_arac VALUES (41,112);
INSERT INTO resim_arac VALUES (37,112);
INSERT INTO resim_arac VALUES (38,113);
INSERT INTO resim_arac VALUES (39,113);
INSERT INTO resim_arac VALUES (40,113);
INSERT INTO resim_arac VALUES (41,113);
INSERT INTO resim_arac VALUES (37,113);
INSERT INTO resim_arac VALUES (38,114);
INSERT INTO resim_arac VALUES (39,114);
INSERT INTO resim_arac VALUES (40,114);
INSERT INTO resim_arac VALUES (41,114);
INSERT INTO resim_arac VALUES (37,114);
INSERT INTO resim_arac VALUES (38,115);
INSERT INTO resim_arac VALUES (39,115);
INSERT INTO resim_arac VALUES (40,115);
INSERT INTO resim_arac VALUES (41,115);
INSERT INTO resim_arac VALUES (37,115);
INSERT INTO resim_arac VALUES (38,116);
INSERT INTO resim_arac VALUES (39,116);
INSERT INTO resim_arac VALUES (40,116);
INSERT INTO resim_arac VALUES (41,116);
INSERT INTO resim_arac VALUES (37,116);
INSERT INTO resim_arac VALUES (38,118);
INSERT INTO resim_arac VALUES (39,118);
INSERT INTO resim_arac VALUES (40,118);
INSERT INTO resim_arac VALUES (41,118);
INSERT INTO resim_arac VALUES (37,118);
--
INSERT INTO resim_arac VALUES (15,272);
INSERT INTO resim_arac VALUES (15,273);
INSERT INTO resim_arac VALUES (15,274);
INSERT INTO resim_arac VALUES (15,275);
--
INSERT INTO resim_arac VALUES (23,232);
INSERT INTO resim_arac VALUES (24,232);
INSERT INTO resim_arac VALUES (25,232);
INSERT INTO resim_arac VALUES (23,233);
INSERT INTO resim_arac VALUES (24,233);
INSERT INTO resim_arac VALUES (25,233);
INSERT INTO resim_arac VALUES (23,234);
INSERT INTO resim_arac VALUES (24,234);
INSERT INTO resim_arac VALUES (25,234);
INSERT INTO resim_arac VALUES (23,238);
INSERT INTO resim_arac VALUES (24,238);
INSERT INTO resim_arac VALUES (25,238);
--
INSERT INTO resim_arac VALUES (29,150);
INSERT INTO resim_arac VALUES (30,150);
INSERT INTO resim_arac VALUES (29,151);
INSERT INTO resim_arac VALUES (30,151);
INSERT INTO resim_arac VALUES (29,152);
INSERT INTO resim_arac VALUES (30,152);
INSERT INTO resim_arac VALUES (29,153);
INSERT INTO resim_arac VALUES (30,153);
INSERT INTO resim_arac VALUES (29,154);
INSERT INTO resim_arac VALUES (30,154);
INSERT INTO resim_arac VALUES (29,155);
INSERT INTO resim_arac VALUES (30,155);
INSERT INTO resim_arac VALUES (29,156);
INSERT INTO resim_arac VALUES (30,156);
INSERT INTO resim_arac VALUES (29,157);
INSERT INTO resim_arac VALUES (30,157);
INSERT INTO resim_arac VALUES (29,158);
INSERT INTO resim_arac VALUES (30,158);
INSERT INTO resim_arac VALUES (29,159);
INSERT INTO resim_arac VALUES (30,159);
INSERT INTO resim_arac VALUES (29,160);
INSERT INTO resim_arac VALUES (30,160);
INSERT INTO resim_arac VALUES (29,161);
INSERT INTO resim_arac VALUES (30,161);
INSERT INTO resim_arac VALUES (29,162);
INSERT INTO resim_arac VALUES (30,162);
INSERT INTO resim_arac VALUES (29,163);
INSERT INTO resim_arac VALUES (30,163);
INSERT INTO resim_arac VALUES (29,164);
INSERT INTO resim_arac VALUES (30,164);
INSERT INTO resim_arac VALUES (29,165);
INSERT INTO resim_arac VALUES (30,165);
INSERT INTO resim_arac VALUES (29,166);
INSERT INTO resim_arac VALUES (30,166);
INSERT INTO resim_arac VALUES (29,167);
INSERT INTO resim_arac VALUES (30,167);
--
INSERT INTO resim_arac VALUES (32,124);
INSERT INTO resim_arac VALUES (32,125);
INSERT INTO resim_arac VALUES (32,126);
INSERT INTO resim_arac VALUES (32,127);
INSERT INTO resim_arac VALUES (32,128);
INSERT INTO resim_arac VALUES (32,129);
INSERT INTO resim_arac VALUES (32,130);
INSERT INTO resim_arac VALUES (32,131);
INSERT INTO resim_arac VALUES (32,132);
INSERT INTO resim_arac VALUES (32,133);
INSERT INTO resim_arac VALUES (32,134);
INSERT INTO resim_arac VALUES (32,135);
INSERT INTO resim_arac VALUES (32,136);
INSERT INTO resim_arac VALUES (32,137);
INSERT INTO resim_arac VALUES (32,138);
--
INSERT INTO resim_arac VALUES (36,10);
INSERT INTO resim_arac VALUES (36,11);
INSERT INTO resim_arac VALUES (36,12);
INSERT INTO resim_arac VALUES (36,13);
INSERT INTO resim_arac VALUES (36,14);
INSERT INTO resim_arac VALUES (36,15);
INSERT INTO resim_arac VALUES (36,16);
INSERT INTO resim_arac VALUES (36,17);
--
INSERT INTO resim_arac VALUES (26,286);
INSERT INTO resim_arac VALUES (27,286);
INSERT INTO resim_arac VALUES (28,286);
INSERT INTO resim_arac VALUES (26,287);
INSERT INTO resim_arac VALUES (27,287);
INSERT INTO resim_arac VALUES (28,287);
INSERT INTO resim_arac VALUES (26,291);
INSERT INTO resim_arac VALUES (27,291);
INSERT INTO resim_arac VALUES (28,291);
INSERT INTO resim_arac VALUES (26,292);
INSERT INTO resim_arac VALUES (27,292);
INSERT INTO resim_arac VALUES (28,292);
INSERT INTO resim_arac VALUES (26,293);
INSERT INTO resim_arac VALUES (27,293);
INSERT INTO resim_arac VALUES (28,293);
--
INSERT INTO resim_arac VALUES (31,38);
INSERT INTO resim_arac VALUES (31,39);
INSERT INTO resim_arac VALUES (31,40);
INSERT INTO resim_arac VALUES (31,41);
INSERT INTO resim_arac VALUES (31,42);
INSERT INTO resim_arac VALUES (31,43);
INSERT INTO resim_arac VALUES (31,44);
INSERT INTO resim_arac VALUES (31,45);
--
INSERT INTO resim_arac VALUES (35,46);
INSERT INTO resim_arac VALUES (34,46);
INSERT INTO resim_arac VALUES (33,46);
INSERT INTO resim_arac VALUES (35,55);
INSERT INTO resim_arac VALUES (34,55);
INSERT INTO resim_arac VALUES (33,55);
INSERT INTO resim_arac VALUES (35,92);
INSERT INTO resim_arac VALUES (34,92);
INSERT INTO resim_arac VALUES (33,92);
--
INSERT INTO resim_arac VALUES (42,172);
INSERT INTO resim_arac VALUES (43,172);
INSERT INTO resim_arac VALUES (42,173);
INSERT INTO resim_arac VALUES (43,173);
INSERT INTO resim_arac VALUES (42,174);
INSERT INTO resim_arac VALUES (43,174);
INSERT INTO resim_arac VALUES (42,175);
INSERT INTO resim_arac VALUES (43,175);
INSERT INTO resim_arac VALUES (42,176);
INSERT INTO resim_arac VALUES (43,176);
INSERT INTO resim_arac VALUES (42,177);
INSERT INTO resim_arac VALUES (43,177);
INSERT INTO resim_arac VALUES (42,178);
INSERT INTO resim_arac VALUES (43,178);
INSERT INTO resim_arac VALUES (42,179);
INSERT INTO resim_arac VALUES (43,179);
INSERT INTO resim_arac VALUES (42,180);
INSERT INTO resim_arac VALUES (43,180);
INSERT INTO resim_arac VALUES (42,181);
INSERT INTO resim_arac VALUES (43,181);
INSERT INTO resim_arac VALUES (42,182);
INSERT INTO resim_arac VALUES (43,182);
INSERT INTO resim_arac VALUES (42,183);
INSERT INTO resim_arac VALUES (43,183);
INSERT INTO resim_arac VALUES (42,184);
INSERT INTO resim_arac VALUES (43,184);
INSERT INTO resim_arac VALUES (42,185);
INSERT INTO resim_arac VALUES (43,185);
INSERT INTO resim_arac VALUES (42,186);
INSERT INTO resim_arac VALUES (43,186);
INSERT INTO resim_arac VALUES (42,187);
INSERT INTO resim_arac VALUES (43,187);
INSERT INTO resim_arac VALUES (42,188);
INSERT INTO resim_arac VALUES (43,188);
INSERT INTO resim_arac VALUES (42,189);
INSERT INTO resim_arac VALUES (43,189);
INSERT INTO resim_arac VALUES (42,190);
INSERT INTO resim_arac VALUES (43,190);
INSERT INTO resim_arac VALUES (42,191);
INSERT INTO resim_arac VALUES (43,191);
INSERT INTO resim_arac VALUES (42,192);
INSERT INTO resim_arac VALUES (43,192);
INSERT INTO resim_arac VALUES (42,193);
INSERT INTO resim_arac VALUES (43,193);
INSERT INTO resim_arac VALUES (42,194);
INSERT INTO resim_arac VALUES (43,194);
INSERT INTO resim_arac VALUES (42,195);
INSERT INTO resim_arac VALUES (43,195);
INSERT INTO resim_arac VALUES (42,196);
INSERT INTO resim_arac VALUES (43,196);
INSERT INTO resim_arac VALUES (42,197);
INSERT INTO resim_arac VALUES (43,197);
INSERT INTO resim_arac VALUES (42,198);
INSERT INTO resim_arac VALUES (43,198);
INSERT INTO resim_arac VALUES (42,199);
INSERT INTO resim_arac VALUES (43,199);
INSERT INTO resim_arac VALUES (42,200);
INSERT INTO resim_arac VALUES (43,200);
INSERT INTO resim_arac VALUES (42,201);
INSERT INTO resim_arac VALUES (43,201);
INSERT INTO resim_arac VALUES (42,202);
INSERT INTO resim_arac VALUES (43,202);
INSERT INTO resim_arac VALUES (42,203);
INSERT INTO resim_arac VALUES (43,203);
INSERT INTO resim_arac VALUES (42,204);
INSERT INTO resim_arac VALUES (43,204);
INSERT INTO resim_arac VALUES (42,205);
INSERT INTO resim_arac VALUES (43,205);
INSERT INTO resim_arac VALUES (42,206);
INSERT INTO resim_arac VALUES (43,206);
INSERT INTO resim_arac VALUES (42,207);
INSERT INTO resim_arac VALUES (43,207);
INSERT INTO resim_arac VALUES (42,208);
INSERT INTO resim_arac VALUES (43,208);
INSERT INTO resim_arac VALUES (42,209);
INSERT INTO resim_arac VALUES (43,209);
INSERT INTO resim_arac VALUES (42,210);
INSERT INTO resim_arac VALUES (43,210);
INSERT INTO resim_arac VALUES (42,211);
INSERT INTO resim_arac VALUES (43,211);
INSERT INTO resim_arac VALUES (42,212);
INSERT INTO resim_arac VALUES (43,212);
INSERT INTO resim_arac VALUES (42,213);
INSERT INTO resim_arac VALUES (43,213);
INSERT INTO resim_arac VALUES (42,214);
INSERT INTO resim_arac VALUES (43,214);
INSERT INTO resim_arac VALUES (42,215);
INSERT INTO resim_arac VALUES (43,215);
INSERT INTO resim_arac VALUES (42,216);
INSERT INTO resim_arac VALUES (43,216);
INSERT INTO resim_arac VALUES (42,217);
INSERT INTO resim_arac VALUES (43,217);
INSERT INTO resim_arac VALUES (42,218);
INSERT INTO resim_arac VALUES (43,218);
INSERT INTO resim_arac VALUES (42,219);
INSERT INTO resim_arac VALUES (43,219);
INSERT INTO resim_arac VALUES (42,220);
INSERT INTO resim_arac VALUES (43,220);
INSERT INTO resim_arac VALUES (42,221);
INSERT INTO resim_arac VALUES (43,221);
INSERT INTO resim_arac VALUES (42,222);
INSERT INTO resim_arac VALUES (43,222);
--
INSERT INTO resim_arac VALUES (44,260);
INSERT INTO resim_arac VALUES (45,260);
INSERT INTO resim_arac VALUES (44,261);
INSERT INTO resim_arac VALUES (45,261);
INSERT INTO resim_arac VALUES (44,262);
INSERT INTO resim_arac VALUES (45,262);
INSERT INTO resim_arac VALUES (44,263);
INSERT INTO resim_arac VALUES (45,263);
INSERT INTO resim_arac VALUES (44,264);
INSERT INTO resim_arac VALUES (45,264);
INSERT INTO resim_arac VALUES (44,265);
INSERT INTO resim_arac VALUES (45,265);
--
INSERT INTO resim_arac VALUES (20,245);
INSERT INTO resim_arac VALUES (46,245);
INSERT INTO resim_arac VALUES (47,245);
INSERT INTO resim_arac VALUES (20,246);
INSERT INTO resim_arac VALUES (46,246);
INSERT INTO resim_arac VALUES (47,246);
INSERT INTO resim_arac VALUES (20,247);
INSERT INTO resim_arac VALUES (46,247);
INSERT INTO resim_arac VALUES (47,247);
INSERT INTO resim_arac VALUES (20,248);
INSERT INTO resim_arac VALUES (46,248);
INSERT INTO resim_arac VALUES (47,248);
INSERT INTO resim_arac VALUES (20,249);
INSERT INTO resim_arac VALUES (46,249);
INSERT INTO resim_arac VALUES (47,249);
--
INSERT INTO resim_arac VALUES (21,280);
INSERT INTO resim_arac VALUES (22,280);
INSERT INTO resim_arac VALUES (21,281);
INSERT INTO resim_arac VALUES (22,281);
--
INSERT INTO resim_arac VALUES (28,284);
INSERT INTO resim_arac VALUES (48,284);
INSERT INTO resim_arac VALUES (28,285);
INSERT INTO resim_arac VALUES (48,285);
INSERT INTO resim_arac VALUES (28,288);
INSERT INTO resim_arac VALUES (48,288);
INSERT INTO resim_arac VALUES (28,289);
INSERT INTO resim_arac VALUES (48,289);
INSERT INTO resim_arac VALUES (28,290);
INSERT INTO resim_arac VALUES (48,290);
COMMIT; 
/*
266,268,271 : 1990-1994 XJS Cabrio
253,254,255,256,257,258 : 1994-1997 XJ
250 : 1997-2003 XJ 4.0 363hp Otomatik
251,252 : 1997-2003 XJ -1
102...110: 1998-2007 S-type
259 : 1992-1994 xj220 - 1
269-270: 1994-1996 XJS 4.0 233hp Cabrio
111,112,113,114,115,116,118 : Jaguar X-Type
272,273,274,275 : 1998-2005 XK Coupe
232,233,234,238 : 2009-2012 XJ
150-167: 2009-2015 XF
172-222 : 2015-2021 XF
124-138 : 2015-2018 XE
10-17 : 2020-2021 e-pace
286,287,291,292,293: 2011-2014 XK Cabrio 1
38-45: 2013-2017 F-Type Cabrio
46,55,92: 2016-2021 F-Type 5.0 575hp... 
260-265: 1990-1996 jaguar xjs coupe
245-249: 2003-2005 XJ 4.2 400hp Otomatik 2
280-281: 2006-2008 XK 4.2 416hp Otomatik Coupe
284,285,288,289,290: XK 5.0 5_0hp Otm. Coupe
*/
--SELECT * FROM v_arac_linkli_resim

CREATE OR REPLACE VIEW v_arac_linkli_resim AS
  SELECT m_s_id,
         COUNT(*) as resim_adet,
         LISTAGG(resimler_linkli, ' ') WITHIN GROUP (ORDER BY m_s_id) resim_link
    FROM (
          SELECT m_s_id,
                 '<a href="'||resim_path||'"  target="_blank" rel="noreferrer noopener" style="color:blue">'||TO_CHAR(resim_no)||'</a>' as resimler_linkli
            FROM 
                 (
                 SELECT m_s_id,resim_path,
                        ROW_NUMBER() OVER (PARTITION BY m_s_id ORDER BY resim_path ASC) AS resim_no
                   FROM resim_arac ra
                        INNER JOIN resim r ON ra.resim_id = r.resim_id
                 )
         )
GROUP BY m_s_id;


--SELECT * FROM v_Jaguar_modelleri_yil_bazli ORDER BY dbms_random.value();

CREATE OR REPLACE VIEW v_Jaguar_modelleri_yil_bazli AS
SELECT a.m_s_id, y.yil,m.model_ad,a.kasa_kodu, 
       TO_CHAR(a.motor_hacmi)|| 'cc' as motor_hacmi,
       m.model_ad
       ||TO_CHAR(ROUND(a.motor_hacmi/1000,1),'9.9') 
       || CASE WHEN a.yakit_tipi = 'Dizel' THEN 'd' END 
       || ' '|| a.hp||'hp'
       || CASE WHEN a.cekis = 'AWD' THEN ' '||a.cekis END 
       || CASE WHEN a.sanziman = 'OV' THEN ' Otm.' END 
       || CASE WHEN k.kasa_tipi<>'Sedan' THEN ' '||k.kasa_tipi END AS arac,
       a.performans_0_100_sn, a.ort_yakit_tuketimi,
       TO_CHAR(uretim_baslangic) ||'-'|| TO_CHAR(uretim_bitis) AS uretim_yili,
       k.kasa_tipi,
       r.resim_adet,
       r.resim_link
  FROM motor_sanziman_secenegi a
       INNER JOIN yil y on y.yil BETWEEN a.uretim_baslangic and NVL(a.uretim_bitis,2100)
       INNER JOIN jaguar_modelleri m on m.model_id = a.model_id
       INNER JOIN kasa_tipi k on k.kasa_tip_id = a.kasa_tip_id
       LEFT JOIN v_arac_linkli_resim r ON a.m_s_id = r.m_s_id;
       

 --SELECT * FROM yil_bazli_yakit_perf_enleri;
CREATE OR REPLACE VIEW yil_bazli_yakit_perf_enleri AS
  SELECT DISTINCT 
         yil,
         FIRST_VALUE(arac) OVER (PARTITION BY yil ORDER BY ort_yakit_tuketimi ASC) AS yakiti_en_az_olan_jaguar,
         FIRST_VALUE(ort_yakit_tuketimi) OVER (PARTITION BY YIL ORDER BY ort_yakit_tuketimi ASC) AS yakit_ort,
         FIRST_VALUE(resim_link) OVER (PARTITION BY YIL ORDER BY ort_yakit_tuketimi ASC) AS resim_link_az_yak,
         FIRST_VALUE(arac) OVER (PARTITION BY YIL ORDER BY performans_0_100_sn ASC) AS en_performansli_jaguar,
         FIRST_VALUE(performans_0_100_sn) OVER (PARTITION BY YIL ORDER BY performans_0_100_sn ASC) AS hizlanma_0_100,
         FIRST_VALUE(resim_link) OVER (PARTITION BY YIL ORDER BY performans_0_100_sn ASC) AS resim_link_perf
    FROM v_Jaguar_modelleri_yil_bazli
ORDER BY 1 ;


--SELECT * FROM yil_bazli_yakit_perf_enleri;


SELECT    '<table border="1">' as HTML_TABLE FROM dual UNION ALL 
SELECT    '<thead> <tr>' FROM dual UNION ALL 
SELECT       '<th>Yil</th><th>Yakiti En Az Olan Jaguar</th><th>Yakit Ort.</th><th>Rsm Az Yak.</th><th>En Performansli Jaguar</th><th>0-100 Hizlanma</th><th>Rsm Perf.</th>' Sutun_basliklari FROM DUAL UNION ALL 
select    '</tr></thead>' FROM dual UNION ALL 
select    '<tbody>' FROM dual UNION ALL 
(SELECT      '<tr> <td>'||yil||'</td>'
                ||'<td'||CASE WHEN LENGTH(yakiti_en_az_olan_jaguar)>25 THEN ' style="font-size: 80%"' END||'>'||yakiti_en_az_olan_jaguar||'</td>'
                ||'<td>'||yakit_ort||'</td>'
                ||'<td>'||resim_link_az_yak||'</td>'
                ||'<td'||CASE WHEN LENGTH(en_performansli_jaguar)>25 THEN ' style="font-size: 80%"' END||'>'||en_performansli_jaguar||'</td>'
                ||'<td>'||hizlanma_0_100||'</td>'
                ||'<td>'||resim_link_perf||'</td></tr>' 
   FROM yil_bazli_yakit_perf_enleri)
UNION ALL 
SELECT    '</tbody>' FROM dual UNION ALL 
SELECT    '</table>' FROM dual 


