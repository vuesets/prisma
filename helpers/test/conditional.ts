/**
 * Only execute a test if the condition is true.
 *
 * Example:
 *
 * ```
 * testIf(useNodeAPI)('N-API test', async () => { ... })
 * testIf(!useNodeAPI)('binary test', async () => { ... })
 * ```
 */
export const testIf = (condition: boolean) => (condition ? test : test.skip)

/**
 * Similar to `testIf`, only execute the sub-tests if the condition is true.
 *
 * Example:
 *
 * ```
 * describeIf(!skipMsSql)(() => {
 *   beforeEach(async () => {
 *     await setupMSSQL();
 *   })
 *   test('create user', async () => { ... })
 * })
 * ```
 */
export const describeIf = (condition: boolean) => (condition ? describe : describe.skip)
