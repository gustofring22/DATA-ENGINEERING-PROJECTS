-- STEP 1: Create reference lookup table
-- =============================================================
CREATE TABLE IF NOT EXISTS warehouse.ref_condition_categories (
    condition_code      BIGINT          NOT NULL,
    condition_desc      TEXT            NOT NULL,
    sub_category        TEXT            NOT NULL,
    category            TEXT            NOT NULL
);

-- STEP 2: Insert condition groupings
-- =============================================================
INSERT INTO warehouse.ref_condition_categories 
    (condition_code, condition_desc, sub_category, category)
VALUES

-- =============================================================
-- CARDIOVASCULAR
-- =============================================================
(22298006,  'Myocardial Infarction',                                'Heart Disease',        'Cardiovascular'),
(49436004,  'Atrial Fibrillation',                                  'Heart Disease',        'Cardiovascular'),
(53741008,  'Coronary Heart Disease',                               'Heart Disease',        'Cardiovascular'),
(84114007,  'Heart failure (disorder)',                             'Heart Disease',        'Cardiovascular'),
(88805009,  'Chronic congestive heart failure (disorder)',          'Heart Disease',        'Cardiovascular'),
(410429000, 'Cardiac Arrest',                                       'Heart Disease',        'Cardiovascular'),
(86175003,  'Injury of heart (disorder)',                           'Heart Disease',        'Cardiovascular'),
(399211009, 'History of myocardial infarction (situation)',         'Heart Disease',        'Cardiovascular'),
(429007001, 'History of cardiac arrest (situation)',                'Heart Disease',        'Cardiovascular'),
(59621000,  'Hypertension',                                         'Vascular',             'Cardiovascular'),
(230690007, 'Stroke',                                               'Vascular',             'Cardiovascular'),
(132281000119108, 'Acute deep venous thrombosis (disorder)',        'Vascular',             'Cardiovascular'),
(706870000, 'Acute pulmonary embolism (disorder)',                  'Vascular',             'Cardiovascular'),
(55822004,  'Hyperlipidemia',                                       'Vascular',             'Cardiovascular'),
(302870006, 'Hypertriglyceridemia (disorder)',                      'Vascular',             'Cardiovascular'),

-- =============================================================
-- RESPIRATORY
-- =============================================================
(195967001, 'Asthma',                                               'Chronic Respiratory',  'Respiratory'),
(233678006, 'Childhood asthma',                                     'Chronic Respiratory',  'Respiratory'),
(185086009, 'Chronic obstructive bronchitis (disorder)',            'Chronic Respiratory',  'Respiratory'),
(87433001,  'Pulmonary emphysema (disorder)',                       'Chronic Respiratory',  'Respiratory'),
(190905008, 'Cystic Fibrosis',                                      'Chronic Respiratory',  'Respiratory'),
(10509002,  'Acute bronchitis (disorder)',                          'Acute Respiratory',    'Respiratory'),
(65710008,  'Acute respiratory failure (disorder)',                 'Acute Respiratory',    'Respiratory'),
(67782005,  'Acute respiratory distress syndrome (disorder)',       'Acute Respiratory',    'Respiratory'),
(233604007, 'Pneumonia (disorder)',                                  'Acute Respiratory',    'Respiratory'),
(271825005, 'Respiratory distress (finding)',                       'Acute Respiratory',    'Respiratory'),
(267036007, 'Dyspnea (finding)',                                    'Acute Respiratory',    'Respiratory'),
(49727002,  'Cough (finding)',                                      'Acute Respiratory',    'Respiratory'),
(56018004,  'Wheezing (finding)',                                   'Acute Respiratory',    'Respiratory'),
(66857006,  'Hemoptysis (finding)',                                 'Acute Respiratory',    'Respiratory'),
(389087006, 'Hypoxemia (disorder)',                                  'Acute Respiratory',    'Respiratory'),

-- =============================================================
-- METABOLIC
-- =============================================================
(44054006,  'Diabetes',                                             'Diabetes',             'Metabolic'),
(15777000,  'Prediabetes',                                          'Diabetes',             'Metabolic'),
(80394007,  'Hyperglycemia (disorder)',                             'Diabetes',             'Metabolic'),
(127013003, 'Diabetic renal disease (disorder)',                    'Diabetes',             'Metabolic'),
(422034002, 'Diabetic retinopathy associated with type II diabetes','Diabetes',             'Metabolic'),
(1501000119109,'Proliferative diabetic retinopathy type II',       'Diabetes',             'Metabolic'),
(1551000119108,'Nonproliferative diabetic retinopathy type 2',     'Diabetes',             'Metabolic'),
(60951000119105,'Blindness due to type 2 diabetes mellitus',       'Diabetes',             'Metabolic'),
(90781000119102,'Microalbuminuria due to type 2 diabetes',         'Diabetes',             'Metabolic'),
(97331000119101,'Macular edema due to type 2 diabetes',            'Diabetes',             'Metabolic'),
(157141000119108,'Proteinuria due to type 2 diabetes',             'Diabetes',             'Metabolic'),
(368581000119106,'Neuropathy due to type 2 diabetes',              'Diabetes',             'Metabolic'),
(237602007, 'Metabolic syndrome X (disorder)',                      'Metabolic Syndrome',   'Metabolic'),
(162864005, 'Body mass index 30+ - obesity (finding)',              'Metabolic Syndrome',   'Metabolic'),
(408512008, 'Body mass index 40+ - severely obese (finding)',       'Metabolic Syndrome',   'Metabolic'),
(90560007,  'Gout',                                                 'Metabolic Syndrome',   'Metabolic'),

-- =============================================================
-- CANCER
-- =============================================================
(93761005,  'Primary malignant neoplasm of colon',                 'Colorectal Cancer',    'Cancer'),
(94260004,  'Secondary malignant neoplasm of colon',               'Colorectal Cancer',    'Cancer'),
(109838007, 'Overlapping malignant neoplasm of colon',             'Colorectal Cancer',    'Cancer'),
(363406005, 'Malignant tumor of colon',                            'Colorectal Cancer',    'Cancer'),
(68496003,  'Polyp of colon',                                      'Colorectal Cancer',    'Cancer'),
(713197008, 'Recurrent rectal polyp',                              'Colorectal Cancer',    'Cancer'),
(92691004,  'Carcinoma in situ of prostate (disorder)',            'Prostate Cancer',      'Cancer'),
(126906006, 'Neoplasm of prostate',                                'Prostate Cancer',      'Cancer'),
(314994000, 'Metastasis from malignant tumor of prostate',         'Prostate Cancer',      'Cancer'),
(254837009, 'Malignant neoplasm of breast (disorder)',             'Breast Cancer',        'Cancer'),
(254632001, 'Small cell carcinoma of lung (disorder)',             'Lung Cancer',          'Cancer'),
(254637007, 'Non-small cell lung cancer (disorder)',               'Lung Cancer',          'Cancer'),
(162573006, 'Suspected lung cancer (situation)',                   'Lung Cancer',          'Cancer'),
(424132000, 'Non-small cell carcinoma of lung TNM stage 1',        'Lung Cancer',          'Cancer'),
(67811000119102,'Primary small cell malignant neoplasm of lung',   'Lung Cancer',          'Cancer'),

-- =============================================================
-- MUSCULOSKELETAL
-- =============================================================
(57676002,  'Joint pain (finding)',                                 'Joint Disorders',      'Musculoskeletal'),
(69896004,  'Rheumatoid arthritis',                                 'Joint Disorders',      'Musculoskeletal'),
(201834006, 'Localized primary osteoarthritis of the hand',        'Joint Disorders',      'Musculoskeletal'),
(239872002, 'Osteoarthritis of hip',                               'Joint Disorders',      'Musculoskeletal'),
(239873007, 'Osteoarthritis of knee',                              'Joint Disorders',      'Musculoskeletal'),
(64859006,  'Osteoporosis (disorder)',                             'Bone Disorders',       'Musculoskeletal'),
(443165006, 'Pathological fracture due to osteoporosis',           'Bone Disorders',       'Musculoskeletal'),
(1734006,   'Fracture of the vertebral column with spinal cord',   'Fractures',            'Musculoskeletal'),
(16114001,  'Fracture of ankle',                                   'Fractures',            'Musculoskeletal'),
(33737001,  'Fracture of rib',                                     'Fractures',            'Musculoskeletal'),
(58150001,  'Fracture of clavicle',                                'Fractures',            'Musculoskeletal'),
(65966004,  'Fracture of forearm',                                 'Fractures',            'Musculoskeletal'),
(359817006, 'Closed fracture of hip',                              'Fractures',            'Musculoskeletal'),
(263102004, 'Fracture subluxation of wrist',                       'Fractures',            'Musculoskeletal'),
(44465007,  'Sprain of ankle',                                     'Sprains',              'Musculoskeletal'),
(70704007,  'Sprain of wrist',                                     'Sprains',              'Musculoskeletal'),
(239720000, 'Tear of meniscus of knee',                            'Sprains',              'Musculoskeletal'),
(444470001, 'Injury of anterior cruciate ligament',                'Sprains',              'Musculoskeletal'),
(444448004, 'Injury of medial collateral ligament of knee',        'Sprains',              'Musculoskeletal'),
(307731004, 'Injury of tendon of the rotator cuff of shoulder',    'Sprains',              'Musculoskeletal'),
(30832001,  'Rupture of patellar tendon',                          'Sprains',              'Musculoskeletal'),
(39848009,  'Whiplash injury to neck',                             'Sprains',              'Musculoskeletal'),
(82423001,  'Chronic pain',                                        'Pain Disorders',       'Musculoskeletal'),
(68962001,  'Muscle pain (finding)',                               'Pain Disorders',       'Musculoskeletal'),
(95417003,  'Primary fibromyalgia syndrome',                       'Pain Disorders',       'Musculoskeletal'),

-- =============================================================
-- NEUROLOGICAL
-- =============================================================
(26929004,  'Alzheimer''s disease (disorder)',                     'Dementia',             'Neurological'),
(230265002, 'Familial Alzheimer''s disease of early onset',        'Dementia',             'Neurological'),
(84757009,  'Epilepsy',                                            'Seizure Disorders',    'Neurological'),
(128613002, 'Seizure disorder',                                    'Seizure Disorders',    'Neurological'),
(703151001, 'History of single seizure (situation)',               'Seizure Disorders',    'Neurological'),
(127295002, 'Traumatic brain injury (disorder)',                   'Brain Injury',         'Neurological'),
(110030002, 'Concussion injury of brain',                          'Brain Injury',         'Neurological'),
(275272006, 'Brain damage - traumatic',                            'Brain Injury',         'Neurological'),
(62106007,  'Concussion with no loss of consciousness',            'Brain Injury',         'Neurological'),
(62564004,  'Concussion with loss of consciousness',               'Brain Injury',         'Neurological'),
(698754002, 'Chronic paralysis due to lesion of spinal cord',      'Spinal Disorders',     'Neurological'),
(124171000119105,'Chronic intractable migraine without aura',      'Headache',             'Neurological'),
(25064002,  'Headache (finding)',                                   'Headache',             'Neurological'),

-- =============================================================
-- MENTAL HEALTH
-- =============================================================
(370143000, 'Major depression disorder',                           'Depression',           'Mental Health'),
(47505003,  'Posttraumatic stress disorder',                       'Anxiety & Trauma',     'Mental Health'),
(225444004, 'At risk for suicide (finding)',                       'Anxiety & Trauma',     'Mental Health'),
(192127007, 'Child attention deficit disorder',                    'Behavioural',          'Mental Health'),
(5602001,   'Opioid abuse (disorder)',                             'Substance Abuse',      'Mental Health'),
(7200002,   'Alcoholism',                                          'Substance Abuse',      'Mental Health'),
(55680006,  'Drug overdose',                                       'Substance Abuse',      'Mental Health'),
(449868002, 'Smokes tobacco daily',                                'Substance Abuse',      'Mental Health'),

-- =============================================================
-- INFECTIOUS DISEASE
-- =============================================================
(840539006, 'COVID-19',                                            'Viral Infections',     'Infectious Disease'),
(840544004, 'Suspected COVID-19',                                  'Viral Infections',     'Infectious Disease'),
(770349000, 'Sepsis caused by virus (disorder)',                   'Viral Infections',     'Infectious Disease'),
(87628006,  'Bacterial infectious disease (disorder)',             'Bacterial Infections', 'Infectious Disease'),
(43878008,  'Streptococcal sore throat (disorder)',                'Bacterial Infections', 'Infectious Disease'),
(38822007,  'Cystitis',                                            'Bacterial Infections', 'Infectious Disease'),
(197927001, 'Recurrent urinary tract infection',                   'Bacterial Infections', 'Infectious Disease'),
(301011002, 'Escherichia coli urinary tract infection',            'Bacterial Infections', 'Infectious Disease'),
(76571007,  'Septic shock (disorder)',                             'Bacterial Infections', 'Infectious Disease'),
(75498004,  'Acute bacterial sinusitis (disorder)',                'Bacterial Infections', 'Infectious Disease'),
(65363002,  'Otitis media',                                        'Bacterial Infections', 'Infectious Disease'),

-- =============================================================
-- RENAL
-- =============================================================
(431855005, 'Chronic kidney disease stage 1 (disorder)',           'Chronic Kidney',       'Renal'),
(431856006, 'Chronic kidney disease stage 2 (disorder)',           'Chronic Kidney',       'Renal'),
(433144002, 'Chronic kidney disease stage 3 (disorder)',           'Chronic Kidney',       'Renal'),
(40095003,  'Injury of kidney (disorder)',                         'Kidney Injury',        'Renal'),

-- =============================================================
-- GASTROINTESTINAL
-- =============================================================
(74400008,  'Appendicitis',                                        'Appendix',             'Gastrointestinal'),
(47693006,  'Rupture of appendix',                                 'Appendix',             'Gastrointestinal'),
(428251008, 'History of appendectomy',                             'Appendix',             'Gastrointestinal'),
(235919008, 'Cholelithiasis',                                      'Gallbladder',          'Gastrointestinal'),
(65275009,  'Acute Cholecystitis',                                 'Gallbladder',          'Gastrointestinal'),
(6072007,   'Bleeding from anus',                                  'Bowel Disorders',      'Gastrointestinal'),
(236077008, 'Protracted diarrhea',                                 'Bowel Disorders',      'Gastrointestinal'),
(267060006, 'Diarrhea symptom (finding)',                          'Bowel Disorders',      'Gastrointestinal'),
(249497008, 'Vomiting symptom (finding)',                          'Bowel Disorders',      'Gastrointestinal'),
(422587007, 'Nausea (finding)',                                    'Bowel Disorders',      'Gastrointestinal'),

-- =============================================================
-- REPRODUCTIVE
-- =============================================================
(72892002,  'Normal pregnancy',                                    'Pregnancy',            'Reproductive'),
(47200007,  'Non-low risk pregnancy',                              'Pregnancy',            'Reproductive'),
(19169002,  'Miscarriage in first trimester',                      'Pregnancy',            'Reproductive'),
(79586000,  'Tubal pregnancy',                                     'Pregnancy',            'Reproductive'),
(35999006,  'Blighted ovum',                                       'Pregnancy',            'Reproductive'),
(398254007, 'Preeclampsia',                                        'Pregnancy',            'Reproductive'),
(192127007, 'Child attention deficit disorder',                    'Pregnancy',            'Reproductive'),
(198992004, 'Antepartum eclampsia',                                'Pregnancy',            'Reproductive'),
(156073000, 'Fetus with unknown complication',                     'Pregnancy',            'Reproductive'),
(427089005, 'Male Infertility',                                    'Infertility',          'Reproductive'),
(707577004, 'Female Infertility',                                  'Infertility',          'Reproductive'),

-- =============================================================
-- TRAUMA & INJURY
-- =============================================================
(262574004, 'Bullet wound',                                        'Wounds',               'Trauma & Injury'),
(48333001,  'Burn injury(morphologic abnormality)',                'Burns',                'Trauma & Injury'),
(403190006, 'First degree burn',                                   'Burns',                'Trauma & Injury'),
(403191005, 'Second degree burn',                                  'Burns',                'Trauma & Injury'),
(403192003, 'Third degree burn',                                   'Burns',                'Trauma & Injury'),
(283371005, 'Laceration of forearm',                               'Lacerations',          'Trauma & Injury'),
(283385000, 'Laceration of thigh',                                 'Lacerations',          'Trauma & Injury'),
(284549007, 'Laceration of hand',                                  'Lacerations',          'Trauma & Injury'),
(284551006, 'Laceration of foot',                                  'Lacerations',          'Trauma & Injury'),
(370247008, 'Facial laceration',                                   'Lacerations',          'Trauma & Injury'),
(161622006, 'History of lower limb amputation (situation)',        'Amputation',           'Trauma & Injury'),
(429280009, 'History of amputation of foot (situation)',           'Amputation',           'Trauma & Injury'),
(698423002, 'History of disarticulation at wrist (situation)',     'Amputation',           'Trauma & Injury'),

-- =============================================================
-- ALLERGIES & IMMUNE
-- =============================================================
(232353008, 'Perennial allergic rhinitis with seasonal variation', 'Allergic Rhinitis',    'Allergies & Immune'),
(367498001, 'Seasonal allergic rhinitis',                          'Allergic Rhinitis',    'Allergies & Immune'),
(446096008, 'Perennial allergic rhinitis',                         'Allergic Rhinitis',    'Allergies & Immune'),
(241929008, 'Acute allergic reaction',                             'Allergic Rhinitis',    'Allergies & Immune'),
(200936003, 'Lupus erythematosus',                                 'Autoimmune',           'Allergies & Immune'),
(24079001,  'Atopic dermatitis',                                   'Skin Conditions',      'Allergies & Immune'),
(40275004,  'Contact dermatitis',                                  'Skin Conditions',      'Allergies & Immune'),

-- =============================================================
-- GENERAL SYMPTOMS
-- =============================================================
(386661006, 'Fever (finding)',                                     'Fever & Infection',    'General Symptoms'),
(43724002,  'Chill (finding)',                                     'Fever & Infection',    'General Symptoms'),
(84229001,  'Fatigue (finding)',                                   'General',              'General Symptoms'),
(36955009,  'Loss of taste (finding)',                             'General',              'General Symptoms'),
(267102003, 'Sore throat symptom (finding)',                       'ENT',                  'General Symptoms'),
(68235000,  'Nasal congestion (finding)',                          'ENT',                  'General Symptoms'),
(36971009,  'Sinusitis (disorder)',                                'ENT',                  'General Symptoms'),
(40055000,  'Chronic sinusitis (disorder)',                        'ENT',                  'General Symptoms'),
(444814009, 'Viral sinusitis (disorder)',                          'ENT',                  'General Symptoms'),
(195662009, 'Acute viral pharyngitis (disorder)',                  'ENT',                  'General Symptoms'),
(246677007, 'Passive conjunctival congestion (finding)',           'ENT',                  'General Symptoms'),
(248595008, 'Sputum finding (finding)',                            'ENT',                  'General Symptoms'),
(196416002, 'Impacted molars',                                     'Dental',               'General Symptoms');


