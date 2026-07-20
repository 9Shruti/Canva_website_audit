CREATE DATABASE canva_db;
USE canva_db;

CREATE TABLE website_audit_master (
    audit_id        INT PRIMARY KEY AUTO_INCREMENT,
    website_url     VARCHAR(255)   NOT NULL,
    audit_date      DATE           NOT NULL,
    overall_score   DECIMAL(5,2)   NOT NULL,
    overall_status  VARCHAR(50)    NOT NULL,
    created_at      TIMESTAMP      DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO website_audit_master (website_url, audit_date, overall_score, overall_status)
VALUES ('https://example.com', CURDATE(), 87.00, 'Good');

select * from website_audit_master;

CREATE TABLE categories (
    category_pk     INT PRIMARY KEY AUTO_INCREMENT,
    audit_id        INT           NOT NULL,
    category_id     VARCHAR(10)   NOT NULL UNIQUE,
    category_name   VARCHAR(100)  NOT NULL,
    weight          DECIMAL(4,2)  NOT NULL,
    score           DECIMAL(5,2)  NOT NULL,
    status          VARCHAR(50)   NOT NULL,
    CONSTRAINT fk_categories_audit
        FOREIGN KEY (audit_id) REFERENCES website_audit_master(audit_id)
);

INSERT INTO categories (audit_id, category_id, category_name, weight, score, status) VALUES
(1, 'C1', 'Performance',     0.25, 60.1, 'Needs Improvement'),
(1, 'C2', 'Accessibility',   0.25, 96.0, 'Excellent'),
(1, 'C3', 'Best Practices',  0.25, 90.5, 'Good'),
(1, 'C4', 'SEO',             0.25, 100.0, 'Excellent'),
(1, 'OVR', 'Overall Score',  1.00, 87.0, 'Good');

select * from categories;

CREATE TABLE sub_factors (
    sub_factor_pk   INT PRIMARY KEY AUTO_INCREMENT,
    sub_factor_id   VARCHAR(10)   NOT NULL UNIQUE,
    category_id     VARCHAR(10)   NOT NULL,
    sub_factor_name VARCHAR(150)  NOT NULL,
    weight          DECIMAL(4,2)  NOT NULL,
    score           DECIMAL(5,2)  NOT NULL,
    CONSTRAINT fk_subfactors_category
        FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

INSERT INTO sub_factors (sub_factor_id, category_id, sub_factor_name, weight, score) VALUES
('P1', 'C1', 'Largest Contentful Paint (LCP)', 0.25, 54.3),
('P2', 'C1', 'Total Blocking Time (TBT)',      0.25, 37.7),
('P3', 'C1', 'Cumulative Layout Shift (CLS)',  0.20, 100.0),
('P4', 'C1', 'First Contentful Paint (FCP)',   0.15, 70.0),
('P5', 'C1', 'Speed Index',                    0.15, 44.0),
('A1', 'C2', 'Color Contrast',                 0.25, 100.0),
('A2', 'C2', 'ARIA Dialog Accessibility',      0.25, 90.0),
('A3', 'C2', 'Accessible Names',               0.25, 95.0),
('A4', 'C2', 'Manual Checks',                  0.25, 99.0),
('B1', 'C3', 'Uses HTTPS',                              0.17, 100.0),
('B2', 'C3', 'JavaScript Libraries',                     0.17, 95.0),
('B3', 'C3', 'Source Maps',                              0.16, 77.5),
('B4', 'C3', 'Content Security Policy (CSP)',            0.17, 95.0),
('B5', 'C3', 'Cross-Origin Opener Policy (COOP)',        0.16, 95.0),
('B6', 'C3', 'Trusted Types',                            0.17, 80.0),
('S1', 'C4', 'SEO Audits Passed',              1.00, 100.0);

select * from sub_factors;

CREATE TABLE factors (
    factor_pk       INT PRIMARY KEY AUTO_INCREMENT,
    factor_id       VARCHAR(10)   NOT NULL,
    sub_factor_id   VARCHAR(10)   NOT NULL,
    factor_name     VARCHAR(150)  NOT NULL,
    value           VARCHAR(50)   NOT NULL,
    unit            VARCHAR(20),
    type            VARCHAR(20),
    threshold       VARCHAR(20),
    score           DECIMAL(5,2)  NOT NULL,
    good_range      VARCHAR(50),
    flag            VARCHAR(20),
    CONSTRAINT fk_factors_subfactor
        FOREIGN KEY (sub_factor_id) REFERENCES sub_factors(sub_factor_id)
);

INSERT INTO factors (factor_id, sub_factor_id, factor_name, value, unit, type, threshold, score, good_range, flag) VALUES
('P1F1', 'P1', 'Server Response Time',      '420', 'ms', 'Lower', '200', 48.0, '< 200 ms', '⚠ Fix'),
('P1F2', 'P1', 'Resource Load Time',        '780', 'ms', 'Lower', '500', 55.0, '< 500 ms', '⚠ Fix'),
('P1F3', 'P1', 'Largest Element Render',    '620', 'ms', 'Lower', '300', 60.0, '< 300 ms', '⚠ Fix'),
('P2F1', 'P2', 'JavaScript Execution',      '460', 'ms', 'Lower', '200', 35.0, '< 200 ms', '⚠ Fix'),
('P2F2', 'P2', 'Long Tasks',                '8', 'Count', 'Zero', '0', 30.0, '0', '⚠ Fix'),
('P2F3', 'P2', 'Main Thread Blocking',      '380', 'ms', 'Lower', '200', 48.0, '< 200 ms', '⚠ Fix'),
('P3F1', 'P3', 'Images Without Dimensions', '0', 'Count', 'Zero', '0', 100.0, '0', 'OK'),
('P3F2', 'P3', 'Dynamic Layout Shifts',     '0', 'Count', 'Zero', '0', 100.0, '0', 'OK'),
('P3F3', 'P3', 'Font Loading Shifts',       '0', 'Count', 'Zero', '0', 100.0, '0', 'OK'),
('P4F1', 'P4', 'Server Response',           '240', 'ms', 'Lower', '200', 68.0, '< 200 ms', '⚠ Fix'),
('P4F2', 'P4', 'CSS Rendering',             '210', 'ms', 'Lower', '150', 72.0, '< 150 ms', '⚠ Fix'),
('P4F3', 'P4', 'First Paint',               '980', 'ms', 'Lower', '500', 70.0, '< 500 ms', '⚠ Fix'),
('P5F1', 'P5', 'Above-the-Fold Rendering',  '1650', 'ms', 'Lower', '800', 42.0, '< 800 ms', '⚠ Fix'),
('P5F2', 'P5', 'JavaScript Rendering',      '620', 'ms', 'Lower', '300', 45.0, '< 300 ms', '⚠ Fix'),
('P5F3', 'P5', 'Visual Completion',         '3800', 'ms', 'Lower', '2000', 45.0, '< 2000 ms', '⚠ Fix'),
('A1F1', 'A1', 'Contrast Ratio',            '4.9', 'Ratio', 'Higher', '4.5', 100.0, '≥ 4.5:1', 'OK'),
('A1F2', 'A1', 'Low Contrast Elements',     '0', 'Count', 'Zero', '0', 100.0, '0', 'OK'),
('A2F1', 'A2', 'Missing ARIA Labels',       '1', 'Count', 'Zero', '0', 90.0, '0', 'OK'),
('A2F2', 'A2', 'Invalid Dialog Roles',      '0', 'Count', 'Zero', '0', 90.0, '0', 'OK'),
('A3F1', 'A3', 'Missing Accessible Names',  '0', 'Count', 'Zero', '0', 100.0, '0', 'OK'),
('A3F2', 'A3', 'Empty Labels',              '1', 'Count', 'Zero', '0', 90.0, '0', 'OK'),
('A4F1', 'A4', 'Keyboard Navigation',       'Pass', 'Bool', 'Boolean', '-', 100.0, 'Pass', 'OK'),
('A4F2', 'A4', 'Focus Visibility',          'Pass', 'Bool', 'Boolean', '-', 100.0, 'Pass', 'OK'),
('A4F3', 'A4', 'Screen Reader Support',     'Minor Issues', 'Text', 'Manual', '-', 97.0, 'Pass', 'OK'),
('B1F1', 'B1', 'HTTPS Enabled',             'Yes', 'Bool', 'Boolean', '-', 100.0, 'Yes', 'OK'),
('B1F2', 'B1', 'SSL Certificate Valid',     'Yes', 'Bool', 'Boolean', '-', 100.0, 'Yes', 'OK'),
('B2F1', 'B2', 'Outdated Libraries',        '1', 'Count', 'Zero', '0', 90.0, '0', 'OK'),
('B2F2', 'B2', 'Vulnerable Libraries',      '0', 'Count', 'Zero', '0', 100.0, '0', 'OK'),
('B3F1', 'B3', 'Missing Source Maps',       '2', 'Count', 'Zero', '0', 75.0, '0', '⚠ Fix'),
('B3F2', 'B3', 'Invalid Source Maps',       '1', 'Count', 'Zero', '0', 80.0, '0', '⚠ Fix'),
('B4F1', 'B4', 'CSP Header Present',        'Yes', 'Bool', 'Boolean', '-', 100.0, 'Yes', 'OK'),
('B4F2', 'B4', 'Unsafe Directives',         '1', 'Count', 'Zero', '0', 90.0, '0', 'OK'),
('B5F1', 'B5', 'COOP Header Present',       'Yes', 'Bool', 'Boolean', '-', 100.0, 'Yes', 'OK'),
('B5F2', 'B5', 'Cross-Origin Issues',       '1', 'Count', 'Zero', '0', 90.0, '0', 'OK'),
('B6F1', 'B6', 'Trusted Types Enabled',     'No', 'Bool', 'Boolean', '-', 80.0, 'Yes', '⚠ Fix'),
('B6F2', 'B6', 'Unsafe DOM Injection',      '0', 'Count', 'Zero', '0', 80.0, '0', '⚠ Fix'),
('S1F1', 'S1', 'Meta Tags Present',         'Yes', 'Bool', 'Boolean', '-', 100.0, 'Yes', 'OK'),
('S1F2', 'S1', 'Crawlable Pages',           '1', '%', 'Higher', '100', 100.0, '1', 'OK'),
('S1F3', 'S1', 'Mobile-Friendly',           'Yes', 'Bool', 'Boolean', '-', 100.0, 'Yes', 'OK');

select * from factors;
