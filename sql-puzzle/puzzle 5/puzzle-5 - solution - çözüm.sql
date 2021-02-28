WITH ps AS (
SELECT a.*, 
       CASE WHEN s01='g' THEN 1
            WHEN s02='g' THEN 2
            WHEN s03='g' THEN 3
            WHEN s04='g' THEN 4
            WHEN s05='g' THEN 5
            WHEN s06='g' THEN 6
            WHEN s07='g' THEN 7
            WHEN s08='g' THEN 8
            WHEN s09='g' THEN 9
            WHEN s10='g' THEN 10
            WHEN s11='g' THEN 11
       END as periyot,
       CASE WHEN s11='g' THEN 11
            WHEN s10='g' THEN 10
            WHEN s09='g' THEN 9
            WHEN s08='g' THEN 8
            WHEN s07='g' THEN 7
            WHEN s06='g' THEN 6
            WHEN s05='g' THEN 5
            WHEN s04='g' THEN 4
            WHEN s03='g' THEN 3
            WHEN s02='g' THEN 2
            WHEN s01='g' THEN 1
       END as son
FROM puzzle_5 a
) 
 SELECT SATIR, S00, S01, S02, S03, S04, S05, S06, S07, S08, S09, S10, S11, 
        CASE WHEN periyot=1  and MOD(12-son,periyot)=0 THEN 't'
             WHEN periyot=2  and MOD(12-son,periyot)=0 THEN 't'
             WHEN periyot=3  and MOD(12-son,periyot)=0 THEN 't'
             WHEN periyot=4  and MOD(12-son,periyot)=0 THEN 't'
             WHEN periyot=5  and MOD(12-son,periyot)=0 THEN 't'
             WHEN periyot=6  and MOD(12-son,periyot)=0 THEN 't'
             WHEN periyot=7  and MOD(12-son,periyot)=0 THEN 't'
             WHEN periyot=8  and MOD(12-son,periyot)=0 THEN 't'
             WHEN periyot=9  and MOD(12-son,periyot)=0 THEN 't'
             WHEN periyot=10 and MOD(12-son,periyot)=0 THEN 't'
             WHEN periyot=11 and MOD(12-son,periyot)=0 THEN 't'
        END as S12, 
        CASE WHEN periyot=1  and MOD(13-son,periyot)=0 THEN 't'
             WHEN periyot=2  and MOD(13-son,periyot)=0 THEN 't'
             WHEN periyot=3  and MOD(13-son,periyot)=0 THEN 't'
             WHEN periyot=4  and MOD(13-son,periyot)=0 THEN 't'
             WHEN periyot=5  and MOD(13-son,periyot)=0 THEN 't'
             WHEN periyot=6  and MOD(13-son,periyot)=0 THEN 't'
             WHEN periyot=7  and MOD(13-son,periyot)=0 THEN 't'
             WHEN periyot=8  and MOD(13-son,periyot)=0 THEN 't'
             WHEN periyot=9  and MOD(13-son,periyot)=0 THEN 't'
             WHEN periyot=10 and MOD(13-son,periyot)=0 THEN 't'
             WHEN periyot=11 and MOD(13-son,periyot)=0 THEN 't'
        END as S13,  
        CASE WHEN periyot=1  and MOD(14-son,periyot)=0 THEN 't'
             WHEN periyot=2  and MOD(14-son,periyot)=0 THEN 't'
             WHEN periyot=3  and MOD(14-son,periyot)=0 THEN 't'
             WHEN periyot=4  and MOD(14-son,periyot)=0 THEN 't'
             WHEN periyot=5  and MOD(14-son,periyot)=0 THEN 't'
             WHEN periyot=6  and MOD(14-son,periyot)=0 THEN 't'
             WHEN periyot=7  and MOD(14-son,periyot)=0 THEN 't'
             WHEN periyot=8  and MOD(14-son,periyot)=0 THEN 't'
             WHEN periyot=9  and MOD(14-son,periyot)=0 THEN 't'
             WHEN periyot=10 and MOD(14-son,periyot)=0 THEN 't'
             WHEN periyot=11 and MOD(14-son,periyot)=0 THEN 't'
        END as S14, 
        CASE WHEN periyot=1  and MOD(15-son,periyot)=0 THEN 't'
             WHEN periyot=2  and MOD(15-son,periyot)=0 THEN 't'
             WHEN periyot=3  and MOD(15-son,periyot)=0 THEN 't'
             WHEN periyot=4  and MOD(15-son,periyot)=0 THEN 't'
             WHEN periyot=5  and MOD(15-son,periyot)=0 THEN 't'
             WHEN periyot=6  and MOD(15-son,periyot)=0 THEN 't'
             WHEN periyot=7  and MOD(15-son,periyot)=0 THEN 't'
             WHEN periyot=8  and MOD(15-son,periyot)=0 THEN 't'
             WHEN periyot=9  and MOD(15-son,periyot)=0 THEN 't'
             WHEN periyot=10 and MOD(15-son,periyot)=0 THEN 't'
             WHEN periyot=11 and MOD(15-son,periyot)=0 THEN 't'
        END as S15, 
        CASE WHEN periyot=1  and MOD(16-son,periyot)=0 THEN 't'
             WHEN periyot=2  and MOD(16-son,periyot)=0 THEN 't'
             WHEN periyot=3  and MOD(16-son,periyot)=0 THEN 't'
             WHEN periyot=4  and MOD(16-son,periyot)=0 THEN 't'
             WHEN periyot=5  and MOD(16-son,periyot)=0 THEN 't'
             WHEN periyot=6  and MOD(16-son,periyot)=0 THEN 't'
             WHEN periyot=7  and MOD(16-son,periyot)=0 THEN 't'
             WHEN periyot=8  and MOD(16-son,periyot)=0 THEN 't'
             WHEN periyot=9  and MOD(16-son,periyot)=0 THEN 't'
             WHEN periyot=10 and MOD(16-son,periyot)=0 THEN 't'
             WHEN periyot=11 and MOD(16-son,periyot)=0 THEN 't'
        END as S16, 
        CASE WHEN periyot=1  and MOD(17-son,periyot)=0 THEN 't'
             WHEN periyot=2  and MOD(17-son,periyot)=0 THEN 't'
             WHEN periyot=3  and MOD(17-son,periyot)=0 THEN 't'
             WHEN periyot=4  and MOD(17-son,periyot)=0 THEN 't'
             WHEN periyot=5  and MOD(17-son,periyot)=0 THEN 't'
             WHEN periyot=6  and MOD(17-son,periyot)=0 THEN 't'
             WHEN periyot=7  and MOD(17-son,periyot)=0 THEN 't'
             WHEN periyot=8  and MOD(17-son,periyot)=0 THEN 't'
             WHEN periyot=9  and MOD(17-son,periyot)=0 THEN 't'
             WHEN periyot=10 and MOD(17-son,periyot)=0 THEN 't'
             WHEN periyot=11 and MOD(17-son,periyot)=0 THEN 't'
        END as S17, 
        CASE WHEN periyot=1  and MOD(18-son,periyot)=0 THEN 't'
             WHEN periyot=2  and MOD(18-son,periyot)=0 THEN 't'
             WHEN periyot=3  and MOD(18-son,periyot)=0 THEN 't'
             WHEN periyot=4  and MOD(18-son,periyot)=0 THEN 't'
             WHEN periyot=5  and MOD(18-son,periyot)=0 THEN 't'
             WHEN periyot=6  and MOD(18-son,periyot)=0 THEN 't'
             WHEN periyot=7  and MOD(18-son,periyot)=0 THEN 't'
             WHEN periyot=8  and MOD(18-son,periyot)=0 THEN 't'
             WHEN periyot=9  and MOD(18-son,periyot)=0 THEN 't'
             WHEN periyot=10 and MOD(18-son,periyot)=0 THEN 't'
             WHEN periyot=11 and MOD(18-son,periyot)=0 THEN 't'
        END as S18, 
        CASE WHEN periyot=1  and MOD(19-son,periyot)=0 THEN 't'
             WHEN periyot=2  and MOD(19-son,periyot)=0 THEN 't'
             WHEN periyot=3  and MOD(19-son,periyot)=0 THEN 't'
             WHEN periyot=4  and MOD(19-son,periyot)=0 THEN 't'
             WHEN periyot=5  and MOD(19-son,periyot)=0 THEN 't'
             WHEN periyot=6  and MOD(19-son,periyot)=0 THEN 't'
             WHEN periyot=7  and MOD(19-son,periyot)=0 THEN 't'
             WHEN periyot=8  and MOD(19-son,periyot)=0 THEN 't'
             WHEN periyot=9  and MOD(19-son,periyot)=0 THEN 't'
             WHEN periyot=10 and MOD(19-son,periyot)=0 THEN 't'
             WHEN periyot=11 and MOD(19-son,periyot)=0 THEN 't'
        END as S19,
        CASE WHEN periyot=1  and MOD(20-son,periyot)=0 THEN 't'
             WHEN periyot=2  and MOD(20-son,periyot)=0 THEN 't'
             WHEN periyot=3  and MOD(20-son,periyot)=0 THEN 't'
             WHEN periyot=4  and MOD(20-son,periyot)=0 THEN 't'
             WHEN periyot=5  and MOD(20-son,periyot)=0 THEN 't'
             WHEN periyot=6  and MOD(20-son,periyot)=0 THEN 't'
             WHEN periyot=7  and MOD(20-son,periyot)=0 THEN 't'
             WHEN periyot=8  and MOD(20-son,periyot)=0 THEN 't'
             WHEN periyot=9  and MOD(20-son,periyot)=0 THEN 't'
             WHEN periyot=10 and MOD(20-son,periyot)=0 THEN 't'
             WHEN periyot=11 and MOD(20-son,periyot)=0 THEN 't'
        END as S20,
        CASE WHEN periyot=1  and MOD(21-son,periyot)=0 THEN 't'
             WHEN periyot=2  and MOD(21-son,periyot)=0 THEN 't'
             WHEN periyot=3  and MOD(21-son,periyot)=0 THEN 't'
             WHEN periyot=4  and MOD(21-son,periyot)=0 THEN 't'
             WHEN periyot=5  and MOD(21-son,periyot)=0 THEN 't'
             WHEN periyot=6  and MOD(21-son,periyot)=0 THEN 't'
             WHEN periyot=7  and MOD(21-son,periyot)=0 THEN 't'
             WHEN periyot=8  and MOD(21-son,periyot)=0 THEN 't'
             WHEN periyot=9  and MOD(21-son,periyot)=0 THEN 't'
             WHEN periyot=10 and MOD(21-son,periyot)=0 THEN 't'
             WHEN periyot=11 and MOD(21-son,periyot)=0 THEN 't'
        END as S21,
        CASE WHEN periyot=1  and MOD(22-son,periyot)=0 THEN 't'
             WHEN periyot=2  and MOD(22-son,periyot)=0 THEN 't'
             WHEN periyot=3  and MOD(22-son,periyot)=0 THEN 't'
             WHEN periyot=4  and MOD(22-son,periyot)=0 THEN 't'
             WHEN periyot=5  and MOD(22-son,periyot)=0 THEN 't'
             WHEN periyot=6  and MOD(22-son,periyot)=0 THEN 't'
             WHEN periyot=7  and MOD(22-son,periyot)=0 THEN 't'
             WHEN periyot=8  and MOD(22-son,periyot)=0 THEN 't'
             WHEN periyot=9  and MOD(22-son,periyot)=0 THEN 't'
             WHEN periyot=10 and MOD(22-son,periyot)=0 THEN 't'
             WHEN periyot=11 and MOD(22-son,periyot)=0 THEN 't'
        END as S22,
        CASE WHEN periyot=1  and MOD(23-son,periyot)=0 THEN 't'
             WHEN periyot=2  and MOD(23-son,periyot)=0 THEN 't'
             WHEN periyot=3  and MOD(23-son,periyot)=0 THEN 't'
             WHEN periyot=4  and MOD(23-son,periyot)=0 THEN 't'
             WHEN periyot=5  and MOD(23-son,periyot)=0 THEN 't'
             WHEN periyot=6  and MOD(23-son,periyot)=0 THEN 't'
             WHEN periyot=7  and MOD(23-son,periyot)=0 THEN 't'
             WHEN periyot=8  and MOD(23-son,periyot)=0 THEN 't'
             WHEN periyot=9  and MOD(23-son,periyot)=0 THEN 't'
             WHEN periyot=10 and MOD(23-son,periyot)=0 THEN 't'
             WHEN periyot=11 and MOD(23-son,periyot)=0 THEN 't'
        END as S23
 FROM ps 
ORDER BY 1