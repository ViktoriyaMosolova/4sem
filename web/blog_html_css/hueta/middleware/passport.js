const db = require("../db");
const JwtStrategy = require('passport-jwt').Strategy;
const ExtractJwt = require('passport-jwt').ExtractJwt;

const options={
    jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
    secretOrKey: 'dev-jwt'
}

module.exports = passport =>{
    passport.use(
        new JwtStrategy(options, async (payload, done) => {
            try {
                const candidate = await db.query('SELECT * FROM person1 WHERE id = $1', [payload.id]);
                if (candidate.rows.length > 0) {
                    done(null, { login: candidate.rows[0].login, id: candidate.rows[0].id });
                } else {
                    done(null, false);

                }
            } catch (e) {
                console.log(e);
            }
        })
    );
}